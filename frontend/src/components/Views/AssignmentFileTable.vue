<template>
  <div class="assignment_file">
    <el-table
      :data="getFileList()"
      style="width: 100%"
      @cell-click="handleDownload"
    >
      <el-table-column label="File list">
        <template #default="props">
          <div>
            <el-icon v-show="!isDocument(props.row.fileType)">
              <Document />
            </el-icon>
            <el-icon v-show="isDocument(props.row.fileType)">
              <Folder />
            </el-icon>
            {{ props.row.fileName }}
          </div>
        </template>
      </el-table-column>
      <el-table-column label="DownLoadButton" width="180">
        <template #header>
          <el-button type="primary" @click="handleDownloadAll">Download ALL</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  name: "AssignmentResultTable",
  data() {
    return {};
  },
  methods: {
    getFileList() {
      return this.$store.getters.getAssignmentFileList;
    },
    handleDownload(row) {
      console.log("click", row);
      const stuId = this.$store.state.loginStore.userName;
      const filePath = row.filePath;
      fetch(this.$baseUrl + `/assignment/download?stuId=${stuId}&path=${filePath}`, {
        method: "GET",
      })
        .then((response) => {
          if (!response.ok) {
            this.$notifyFailed("Please check your network")
            throw new Error("Network response was not ok");
          }
          // 获取blob对象 binary large object
          return response.blob().then((blob) => {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement("a");  // 创建一个元素，用于模拟点击下载链接
            a.style.display = "none";
            a.href = url;

            const fileName = row.fileName;
            a.download = fileName;
            document.body.appendChild(a);
            a.click();  // 模拟点击行为
            window.URL.revokeObjectURL(url);  // 调用这个方法来让浏览器知道不用在内存中继续保留对这个文件的引用了
            document.body.removeChild(a);
            return; // 防止进一步执行
          });
        })
        .catch((error) => {
          console.error("Error downloading the file: ", error);
        });
    },
    // 抓取所有作业进行下载
    handleDownloadAll(){
      const fileListData = this.getFileList();
      console.log('const data',fileListData);
      fileListData.forEach((col) => {
        if (col['fileType'] === 'FILE'){
          this.handleDownload(col);
        }
      })
    },
    // 决定图标显示内容
    isDocument(fileType) {
      if (fileType === "DOCUMENT") {
        return true;
      }
      return false;
    },
  },
  computed: {},
  created() {
    const studentId = this.$store.state.loginStore.userName;
    const assId = this.$route.query?.assId;
    try {
      this.$store.dispatch("getAssignmentFileList", [assId, studentId]);
    } catch {}
  },
};
</script>
