<template>
  <div class="assignmentResult">
    <el-descriptions
      class="margin-top"
      title="Overall Result"
      direction="vertical"
      :column="3"
      border
    >
      <div>
        <el-descriptions-item>
          <template #label>
            <div class="cell-item">
              <el-icon>
                <user />
              </el-icon>
              Student id
            </div>
          </template>
          {{ this.$store.state.loginStore.userName }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template #label>
            <div class="cell-item">
              <el-icon><Calendar /></el-icon>
              Submit time
            </div>
          </template>
          {{ getAssignmentInfo.submitTime }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template #label>
            <div class="cell-item">
              <el-icon><Calendar /></el-icon>
              Deadline
            </div>
          </template>
          {{ getAssignmentInfo["deadline"] }}
        </el-descriptions-item>

        <el-descriptions-item>
          <template #label>
            <div class="cell-item">Category Offence</div>
          </template>
          {{ getAssignmentInfo.category_offence }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template #label>
            <div class="cell-item">Delay Penalty</div>
          </template>
          {{ getAssignmentInfo.penalty }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template #label>
            <div class="cell-item">
              <el-icon><Stamp /></el-icon>
              Final Mark
            </div>
          </template>
          {{ getTotalMark }}
        </el-descriptions-item>
      </div>
    </el-descriptions>

    <el-table :data="getAssignmentResult" stripe border style="width: 100%">
      <el-table-column type="expand">
        <template #default="props">
          <div class="assignment-detail">
            <el-table :data="props.row.comment" border>
              <el-table-column label="Comment">
                <template #default="scope">
                  <div>
                    {{ scope.row }}
                  </div>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="rubric" label="Marking detail" width="650px" />
      <el-table-column prop="markAndValue" label="Mark"></el-table-column>
    </el-table>

    <AssignmentFileTable />
  </div>
  <!-- {{ getAssignmentResult }} -->
</template>

<script>
import AssignmentFileTable from "./AssignmentFileTable.vue";

export default {
  props: ["role", "code", "assName"], // 显式声明 props
  components: {
    AssignmentFileTable,
  },
  data() {
    return {};
  },
  methods: {
    downloadAssignment(stuId) {
      this.$axios
        .get(`/assignment/download?stuId=${stuId}`)
        .then((response) => {})
        .catch((e) => {});
    },
  },

  computed: {
    getAssignmentInfo() {
      const data = this.$store.getters.getAssignmentInfo;
      if (data["penalty"] > 0) data["penalty"] *= -1;
      return data;
    },
    getTotalMark() {
      let totalMark = 0;
      let totalValue = 0;
      const results = this.$store.getters.getAssignmentResults;
      const assignmentInfo = this.$store.getters.getAssignmentInfo;
      results.forEach((column) => {
        totalMark += column["mark"];
        totalValue += column["value"];
      });
      const [submitTime, deadline] = [
        assignmentInfo["submitTime"],
        assignmentInfo["deadline"],
      ];
      let delayDays = assignmentInfo["delayTime"];

      totalMark += assignmentInfo["penalty"];
      // 作业为0分的情况
      if (
        totalMark < 0 ||
        assignmentInfo["category_offence"] === "C" ||
        delayDays > 5
      ) {
        totalMark = 0;
      }
      return totalMark + "/" + totalValue;
    },
    getAssignmentResult() {
      return this.$store.getters.getAssignmentResults.map((column) => {
        column["markAndValue"] = column["mark"] + "/" + column["value"];
        return column;
      });
    },
  },
  created() {
    const [assId, stuId] = [
      this.$route.query.assId,
      this.$store.state.loginStore.userName,
    ];

    // this.$store.dispatch('getAssignmentResultsSimulation', this.$route.query.assId, this.$store.state.loginStore.userName);
    this.$store.dispatch("getAssignmentResults", [assId, stuId]);
    this.$store.dispatch("getAssignmentInfo", [assId, stuId]);
  },
};
</script>

<style>
.el-descriptions {
  margin-bottom: 10px;
}
.assignment-detail {
  text-align: left;
  padding-left: 20px;
}
.assignment_file {
  margin-top: 12px;
}
</style>
