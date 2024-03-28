<template>
  <div id="app">
    <el-row>
      <div id="nav">
        <el-menu
          class="el-menu-demo"
          mode="horizontal"
          background-color="white"
          text-color="black"
          active-text-color="#606266"
          router
        >
          <el-menu-item
            ><div class="logo">
              <i class="el-icon-printer"></i> All in One
            </div></el-menu-item
          >

          <el-submenu class="dock-right">
            <template slot="title">Change User</template>
            <el-menu-item
              index="/"
              class="dock-right"
              style="font-family: Seoul Hangang"
              @click="staffOn()"
              >STAFF</el-menu-item
            >
            <el-menu-item
              index="/hr-browse"
              class="dock-right"
              style="font-family: Seoul Hangang"
              @click="hrOn()"
              >HR</el-menu-item
            >
            <el-menu-item
              index="/manager-browse"
              class="dock-right"
              style="font-family: Seoul Hangang"
              @click="managerOn()"
              >MANAGER</el-menu-item
            >
          </el-submenu>
          <el-menu-item
            index="/staff-learning-journey"
            class="dock-right"
            v-if="staffVisible"
            >Staff LJ</el-menu-item
          >
          <el-menu-item index="/" class="dock-right" v-if="staffVisible"
            >Staff Browse</el-menu-item
          >
          <el-menu-item index="/hr-browse" class="dock-right" v-if="hrVisible"
            >HR Browse</el-menu-item
          >
          <el-menu-item
            index="/manager-browse"
            class="dock-right"
            v-if="managerVisible"
            >Manager Browse</el-menu-item
          >
        </el-menu>
      </div>
      <router-view />
    </el-row>
  </div>
</template>

<script>
export default {
  created() {
    console.log('vue app starting')
  },
  data() {
    return {
      staffVisible: true,
      hrVisible: false,
      managerVisible: false
    }
  },
  methods: {
    hrOn() {
      this.staffVisible = false
      this.managerVisible = false
      this.hrVisible = true
    },
    managerOn() {
      this.staffVisible = false
      this.hrVisible = false
      this.managerVisible = true
    },
    staffOn() {
      this.hrVisible = false
      this.managerVisible = false
      this.staffVisible = true
    }
  }
}
</script>

<style lang="scss">
@font-face {
  font-family: 'Seoul Hangang';
  font-style: normal;
  font-weight: 400;
  src: url('https://cdn.jsdelivr.net/gh/jbfactory/jb-skin-fonts/fonts/seoulhangangjungm.woff2')
      format('woff2'),
    url('https://cdn.jsdelivr.net/gh/jbfactory/jb-skin-fonts/fonts/seoulhangangjungm.woff')
      format('woff');
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  // text-align: center;
  font-size: 16px;
  margin: auto;
}

#nav {
  position: sticky;
  top: 0px;
  z-index: 10;
}

.el-menu-item.is-active {
  background-color: #546fff !important;
  color: white !important;
}

.el-menu--horizontal > .el-menu-item.dock-right {
  float: right;
  font-family: 'Seoul Hangang';
}
.el-menu--horizontal > .el-submenu.dock-right {
  float: right;
  font-family: 'Seoul Hangang';
}

i.el-icon-printer {
  color: #546fff !important;
  font-size: 30px !important;
}

.logo {
  font-size: 30px !important;
}
</style>
