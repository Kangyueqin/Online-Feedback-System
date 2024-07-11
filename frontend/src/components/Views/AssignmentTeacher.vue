<template>
  <div class="assignmentResult">
    <el-table
      :data="getAssignmentRubrics"
      stripe
      border
      style="width: 100%"
      row-key="id"
      :expand-row-keys="firstColExpands"
    >
    <!-- Rubric table -->
      <el-table-column type="expand">
        <template #default="rubricProps">
          <!-- Criterion table -->
          <div class="assignment-criteria">
            <el-table
              :data="rubricProps.row.criteria"
              row-key="id"
              :expand-row-keys="secondColExpands"
            >
              <el-table-column type="expand">
                <template
                  #default="CriteriaProps"
                  row-key="CriteriaProps.row.id"
                  :expand-row-keys="secondColExpands"
                >
                <!-- additional_comment list -->
                  <el-table
                    :data="CriteriaProps.row.auto_comments"
                    border
                    style="width: 100%"
                    :row-class-name="tableRowClassName"
                  >
                    <el-table-column
                      prop="content"
                      label="Additional_comment"
                    />
                    <el-table-column label="Generate_range" width="150px">
                      <!-- 第三层嵌套 -->
                      <template #default="commentProps">
                        [{{ commentProps.row.lower_bound }},
                        {{ commentProps.row.upper_bound }}]
                      </template>
                    </el-table-column>
                    <!-- 添加新列的按钮 -->

                    <el-table-column label="Operation">
                      <template #header>
                        <div class="operation-buttons">
                          <el-button
                            type="primary"
                            @click="
                              storageCommentInfo(
                                rubricProps.row.id,
                                CriteriaProps.row.id,
                                0
                              );
                              createComment(
                                CriteriaProps.row.value,
                                CriteriaProps.row.auto_comments
                              );
                            "
                            >Create new
                          </el-button>
                          <el-button-group
                            v-show="hasChanged(CriteriaProps.row)"
                          >
                            <el-button
                              type="primary"
                              @click="saveEdit(CriteriaProps.row)"
                            >
                              Save
                            </el-button>
                            <el-button type="primary" @click="resetData(rubricProps.row.id)">
                              Cancel
                            </el-button>
                          </el-button-group>
                        </div>
                      </template>
                      <template #default="scope">
                        <div class="operation-list-buttons">
                          <!-- 'edit'按钮，用于唤出对话框修改数据 -->
                          <el-button
                            link
                            type="primary"
                            size="small"
                            @click="
                              storageCommentInfo(
                                rubricProps.row.id,
                                CriteriaProps.row.id,
                                scope.row.id
                              );
                              editComment(CriteriaProps.row.value, scope);
                            "
                          >
                            Edit
                          </el-button>

                          <!-- 用ref引用便于定位popover -->
                          <el-popover
                            :ref="getCommentRef(scope.row.id)"
                            placement="top-start"
                            trigger="click"
                            :width="160"
                          >
                          <!-- reference让对话框出现在指定的位置 -->
                            <template #reference>
                              <el-button
                                link
                                type="primary"
                                size="small"
                                slot="reference"
                                auto-closer="showAfter"
                              >
                                Delete
                              </el-button>
                            </template>
                            <p>Are you sure to delete this?</p>
                            <div style="text-align: right; margin: 0">
                              <el-button
                                size="small"
                                type="primary"
                                @click="
                                  storageCommentInfo(
                                    rubricProps.row.id,
                                    CriteriaProps.row.id,
                                    scope.row.id
                                  );
                                  handleCommentDelete();
                                "
                              >
                                confirm
                              </el-button>
                            </div>
                          </el-popover>
                        </div>
                      </template>
                    </el-table-column>
                  </el-table>
                </template>
              </el-table-column>
              <el-table-column prop="criterion" label="Criteria" width="600" />
              <el-table-column prop="value" label="Value" />
            </el-table>
          </div>
          <!-- 展开列表 -->
        </template>
      </el-table-column>
      <el-table-column prop="rubric" label="Rubrics" />
    </el-table>
    <!-- dialog -->
    <el-dialog
      v-model="dialogVisible"
      :modal="true"
      :title="editForm.title"
      width="500"
      draggable="draggable"
    >
      <!-- Eidt表单 -->
      <el-form
        :model="editForm"
        v-if="dialogVisible"
        class="comments_edit"
        label-position="top"
        :rules="editFormRules"
        ref="editForm"
      >
        <el-form-item label="Content" prop="comment">
          <el-input v-model="editForm.comment" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Generate_bound" prop="generateBound">
          <el-col :span="10">
            <el-input-number
              v-model="editForm.generateBound[0]"
            ></el-input-number>
          </el-col>
          <el-col class="text-center" :span="1" style="margin: 0 0.5rem"
            >-</el-col
          >
          <el-col :span="10">
            <el-input-number
              v-model="editForm.generateBound[1]"
            ></el-input-number>
          </el-col>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="dialogVisible = false">Cancel</el-button>
          <el-button type="primary" @click="submitMethod()">
            Confirm
          </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { ElNotification } from "element-plus";

export default {
  props: ["role", "code", "assName"],
  data() {
    return {
      draggable: true,
      showAfter: 10,
      firstColExpands: [], // 记录展开表格，存储展开行的key，每次操作时将该行id放进去
      secondColExpands: [],
      dialogVisible: false,
      currentGenerateRange: [], // 记录选中表格中的生成范围，在唤出表单时更新
      wrongRangeComment: [], // 记录范围不正确的commentId，用以提示用户
      editForm: {
        title: "",
        handleMethod: "", // 用来区分提交表单时的方法
        rubricId: 0, // 存储选中的comment id信息
        criterionId: 0,
        commentId: 0,
        comment: "",
        generateBound: [0, 0],
      },
      editFormRules: {
        comment: [
          {
            required: true,
            message: "content can not be empty",
            trigger: "change",
          },
        ],
        generateBound: [
          { validator: this.validateGenerateBound, trigger: "change" },
        ],
      },
      criterionValue: 0, // 存储点击edit时的criterion value
    };
  },
  computed: {
    getAssignmentRubrics() {
      return this.$store.getters.getAssignmentRubrics;
    },
  },
  methods: {
    //获取comment的ref
    getCommentRef(id) {
      return "comment" + id;
    },
    storageCommentInfo(rubricId, criterionId, commentId) {
      this.editForm.rubricId = rubricId;
      this.editForm.criterionId = criterionId;
      this.editForm.commentId = commentId;
    },
    editComment(criterionValue, scope) {
      this.editForm.handleMethod = "Edit";
      this.editForm.title = "Edit comment";
      // 设置upper bound 的上限值
      this.criterionValue = criterionValue;
      // 快速填充当前的数值
      this.editForm.generateBound = [
        scope.row.lower_bound,
        scope.row.upper_bound,
      ];
      this.editForm.comment = scope.row.content;
      // 显示对话框
      this.dialogVisible = true;
    },
    createComment(criterionValue, commentList) {
      this.getCommentRangeList(commentList);
      this.editForm.handleMethod = "Create";
      this.editForm.title = "Create comment";
      console.log("get value:", criterionValue);
      // 设置upper bound 的上限值
      this.criterionValue = criterionValue;
      this.editForm.generateBound = [0, 0];
      this.editForm.comment = "";
      // 显示对话框
      this.dialogVisible = true;
    },
    // 获取选中列表的生成范围，在调用edit或者create时调用
    getCommentRangeList(commentList) {
      console.log("commentlist", commentList);
    },
    validateComment(rule, value, callback) {
      console.log("validate entered");
      if (value.length === 0) {
        callback(new Error("content can not be empty"));
      }
    },
    validateGenerateBound(rule, value, callback) {
      // 校验生成范围是否合规（低边界不能大于高边界，高边界不能超过总分值，同时分数要连续）
      if (value[0] < 0 || value > this.upperBound) {
        callback(new Error("invalid lower bound"));
      } else if (value[1] < value[0] || value[1] < 0) {
        callback(new Error("invalid upper bound"));
      } else if (value[1] > this.criterionValue) {
        callback(new Error("upper bound can not greater than criterion value"));
      } else {
        callback();
      }
    },
    handleCommentDelete() {
      const [rubricId, criterionId, commentId] = [
        this.editForm.rubricId,
        this.editForm.criterionId,
        this.editForm.commentId,
      ];
      this.keepColExpand(rubricId, criterionId);
      // 根据ref隐藏，让悬浮窗消失
      const ref = this.getCommentRef(commentId);
      console.log("this ref", this.$refs[ref]);
      this.$refs[ref].hide();
      this.$store.dispatch("deleteComment", {
        rubricId,
        criterionId,
        commentId,
      });
    },
    submitMethod() {
      // 验证表单是否有效，无效不调用提交方法
      this.$refs["editForm"].validate((valid) => {
        if (!valid) {
          console.error("invalid form!");
          return false;
        } else {
          this.dialogVisible = false;
          // 因为用的是一个表单，根据title来决定用什么方法
          if (this.editForm.handleMethod === "Edit") this.handleCommentEdit();
          else if (this.editForm.handleMethod === "Create")
            this.handleCommentCreate();
        }
      });
    },
    handleCommentEdit() {
      const [rubricId, criterionId, commentId, comment, generateBound] = [
        this.editForm.rubricId,
        this.editForm.criterionId,
        this.editForm.commentId,
        this.editForm.comment,
        this.editForm.generateBound,
      ];
      console.log('comment content"', comment, "id:", this.editForm.commentId);
      this.$store.dispatch("editComment", {
        rubricId,
        criterionId,
        commentId,
        comment,
        generateBound,
      });
    },
    handleCommentCreate() {
      const [rubricId, criterionId, commentContent, lowerBound, upperBound] = [
        this.editForm.rubricId,
        this.editForm.criterionId,
        this.editForm.comment,
        this.editForm.generateBound[0],
        this.editForm.generateBound[1],
      ];
      const comment = {
        id: this.getvirtualId(), // 前端demo用
        content: commentContent,
        lower_bound: lowerBound,
        upper_bound: upperBound,
      };
      console.log("create entered", rubricId, criterionId);
      this.$store.dispatch("createComment", { rubricId, criterionId, comment });
    },
    // 检查comments是否存在数据更改，如果有就返回true
    hasChanged(criterionObj) {
      if (criterionObj["hasChanged"]) {
        return true;
      } else return false;
    },
    // 用以保存表单更改，将更改后的内容发送到后端
    saveEdit(criterionObj) {
      console.log("access");
      // 范围不规范，返回并弹窗报错
      if (!this.checkRange(criterionObj["auto_comments"])) {
        ElNotification({
          title: "Error",
          message:
            "Please check the range setting(can not overlapped/incontinuity)",
          type: "error",
        });
        return;
      }
      console.log("get criterionobj", criterionObj);
      const criterionId = criterionObj["id"];
      const commentList = criterionObj["auto_comments"];
      criterionObj["hasChanged"] = false;
      console.log("get comments: ", commentList, criterionId);
      const sortedList = commentList.map((element) => {
        if (typeof element.id === "string") {
          element.id = null;
        }
        return element;
      });
      console.log("sorted: ", sortedList);
      this.$store
        .dispatch("saveComments", [criterionId, sortedList])
        .then(() => {
          this.$notifySuccessed();
        })
        .catch((e) => {
          this.$notifyFailed(e);
        });
    },
    // 保存时调用，检查分数设置范围是否连续且不重叠，如果不符合条件不提交表单
    checkRange(commentList) {
      for (let i = 0; i < commentList.length - 1; i++) {
        if (commentList[i].upper_bound + 1 !== commentList[i + 1].lower_bound) {
          // 标注这个评论的id用以提示用户
          this.wrongRangeComment.push(commentList[i].id);
          this.wrongRangeComment.push(commentList[i + 1].id);
          return false;
        }
        else{
          // 如果没有问题，检查范围错误的列表中是否有这个id，有的话删去
          this.wrongRangeComment = this.wrongRangeComment.filter((id) => {
            return id !== commentList[i].id
          });
        }
        console.log('wrong range list: ', this.wrongRangeComment);
      }
      return true;
    },
    tableRowClassName({row, rowIndex}){
      if (this.wrongRangeComment.find((id) => id === row.id)){
        console.log('find wrong row', row.content);
        return 'warning-row';
      }
      else return 'normal-row';
    },
    // 通过重新获取后端数据来重置更改
    resetData(rubricId) {
      this.$store
        .dispatch("getAssignmentRubrics", this.$route.query.assId)
        .then(() => {
          this.$notifySuccessed;
        });
        this.wrongRangeComment = [];
        this.keepColExpand(rubricId, -1);
    },
    keepColExpand(rubricId, criterionId) {
      // 控制列表保持展开
      this.firstColExpands.push(rubricId);
      this.secondColExpands.push(criterionId);
    },
    getvirtualId() {
      return "Vid" + Date.now() + Math.random().toString().slice(2);
    },
  },
  created() {
    // this.$store.dispatch("getAssignmentRubricsSimulation",this.$route.query.assId);
    this.$store
      .dispatch("getAssignmentRubrics", [this.$route.query.assId, this.$store.state.loginStore.userName])
      .then(() => {
        console.log("rubircs:", this.$store.state.assignmentStore.rubrics);
      })
      .catch((e) => {
        if (e.message.status === 404) this.$router.go(-1);
        this.$notifyFailed("error, status code: " + e.response.status);
      });
  },
};
</script>

<style>
.el-button-group {
  margin-left: 12px;
}
.operation-buttons {
  display: flex;
  justify-content: center;
}
.operation-list-buttons {
  display: flex;
  justify-content: center;
}
.assignment-criteria {
  margin-left: 20px;
}
.el-descriptions__title {
  font-size: large;
}
.el-descriptions__header {
  margin-bottom: auto;
}


.el-table .warning-row{
  --el-table-tr-bg-color: var(--el-color-warning-light-3);
}
</style>
