<template>
  <div>
    <div class="main-page" v-if="mainpageVisible">
      <div style="margin-bottom: 20px">
        <el-button
          size="small"
          @click="
            mainpageVisible = false
            formVisible = true
          "
        >
          add Learning Journey
        </el-button>
        <el-button size="small" @click="deleteLJformVisible = true">
          delete Learning Journey
        </el-button>
      </div>
      <el-dialog
        title="Delete Learning Journey"
        :visible.sync="deleteLJformVisible"
        width="35%"
        name="skillFilters"
      >
        <el-form :model="DeleteLJForm">
          <el-form-item label="Learning Journey (Role Name) to delete">
            <el-radio-group
              v-model="DeleteLJForm.RoleNameToDelete"
              @change="checkChosen"
            >
              <div v-for="LJ in this.editableTabs" :key="LJ.LearningJourneyID">
                <el-radio
                  class="black-text"
                  :label="LJ.LearningJourneyID"
                  v-if="LJ.roleStatus === true"
                  ><template slot="default">{{ LJ.title }}</template></el-radio
                >
              </div>
            </el-radio-group>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button
            @click="
              deleteLJformVisible = false
              deleteLearningJourney()
            "
            >Delete</el-button
          >
        </span>
      </el-dialog>
      <el-tabs
        v-model="editableTabsValue"
        type="card"
        v-for="item in editableTabs"
        :key="item.name"
      >
        <el-tab-pane
          :label="item.title"
          :name="item.name"
          lazy
          v-if="item.roleStatus === true"
        >
          <el-col :span="3">
            <div id="LJ-bar">
              <div class="margin-box">
                <br />
                Skills
                <br />
                <br />
                <div
                  v-for="skillOfRole in item.skillsOfRole"
                  :key="skillOfRole"
                >
                  <el-button>{{ skillOfRole }}</el-button>

                  <br />
                </div>
              </div>
            </div>
          </el-col>
          <el-col :span="21">
            <div class="margin-box">
              <span>My Courses(min.1)</span>
            </div>
            <el-dialog :visible.sync="editLjVisible" width="30%">
              <h2>Edit LearningJourney</h2>
              <h3>My Courses</h3>
              <div v-for="itemm of item.myCourses" :key="itemm">
                <el-button-group>
                  <el-button disabled>{{ itemm.course_Name }}</el-button>
                  <el-button @click="removeCourse(item.roleID, itemm.course_ID)"
                    >Remove</el-button
                  >
                </el-button-group>
                <br />
              </div>
              <h3>Recommended Courses</h3>
              <div v-for="itemm of item.recommendedCourses" :key="itemm">
                <el-button-group>
                  <el-button disabled>{{ itemm.course_Name }}</el-button>
                </el-button-group>
                <br /><br /><br />
              </div>
            </el-dialog>
            <div class="scroll-bar-lj">
              <el-row>
                <el-col :span="8" v-for="itemm in item.myCourses" :key="itemm">
                  <div class="course-card" v-if="itemm.course_Is_Active === 1">
                    <el-card shadow="always">
                      <div style="padding: 14px">
                        <el-button @click="registerCourse(itemm.course_ID)"
                          >Register</el-button
                        >
                        <el-button
                          @click="removeCourse(item.roleID, itemm.course_ID)"
                          >Remove</el-button
                        >
                        <h4>Course ID: {{ itemm.course_ID }}</h4>
                        <h3>{{ itemm.course_Name }}</h3>
                        <br />
                        Skills:
                        <ul v-for="cskill in courseskill" :key="cskill.id">
                          <li v-if="cskill.cid === itemm.course_ID">
                            {{ cskill.sNAME }}
                          </li>
                        </ul>
                        <br />
                        <span>Category: {{ itemm.course_Category }}</span>
                        <br />
                        <span>Desc: {{ itemm.course_Desc }}</span>
                        <div class="bottom clearfix">
                          <span>Course Type : {{ itemm.course_Type }}</span>
                          <span class="course-status"
                            >Status:{{ itemm.course_Status }}</span
                          >
                        </div>
                      </div>
                    </el-card>
                  </div>
                </el-col>
              </el-row>
            </div>
            <div class="margin-box"><h2>Recommended Courses</h2></div>
            <div class="scroll-bar-lj">
              <el-row>
                <el-col
                  :span="8"
                  v-for="itemm of item.recommendedCourses"
                  :key="itemm"
                >
                  <div class="course-card" v-if="itemm.course_Is_Active === 1">
                    <el-card :body-style="{padding: '0px'}" shadow="always">
                      <div style="padding: 14px">
                        <el-button
                          @click="addCourse(item.roleID, itemm.course_ID)"
                          >Add</el-button
                        >
                        <h4>Course ID: {{ itemm.course_ID }}</h4>
                        <h3>{{ itemm.course_Name }}</h3>
                        <br />
                        Skills:
                        <ul v-for="cskill in courseskill" :key="cskill.id">
                          <li v-if="cskill.cid === itemm.course_ID">
                            {{ cskill.sNAME }}
                          </li>
                        </ul>
                        <br />
                        <span>Category: {{ itemm.course_Category }}</span>
                        <br />
                        <span>Desc: {{ itemm.course_Desc }}</span>
                        <div class="bottom clearfix">
                          <span>Course Type : {{ itemm.course_Type }}</span>
                          <span class="course-status"
                            >Status:{{ itemm.course_Status }}</span
                          >
                        </div>
                        <el-button
                          @click="addCourse(item.roleID, itemm.course_ID)"
                          >Add</el-button
                        >
                      </div>
                    </el-card>
                  </div>
                </el-col>
              </el-row>
            </div>
            <el-button
              class="lj-start-button"
              @click="startLearningJourney(item.LearningJourneyID)"
              >Start learning journey</el-button
            >
            <el-dialog :visible.sync="ljStartSuccessVisible" width="30%" center>
              <br /><br /><br /><br />
              <div class="success-message">
                <i class="el-icon-success"></i
                ><span> Learning Journey Started</span>
              </div>
              <br /><br /><br /><br /><br /><br />
            </el-dialog>
          </el-col>
        </el-tab-pane>
      </el-tabs>
    </div>
    <div v-if="formVisible" class="roleSelect">
      Select a role
      <el-form :model="formLearningJourney">
        <el-form-item>
          <el-radio-group
            v-model="formLearningJourney.roleChosen"
            @change="checkRoleChosen"
          >
            <div v-for="role in roles" :key="role.role_id">
              <div v-if="role.status === 1">
                <el-radio
                  :label="role.role_id"
                  class="black-text"
                  name="roleFilters"
                >
                  {{ role.role_name }}
                </el-radio>
              </div>
            </div>
          </el-radio-group>
        </el-form-item>
        <el-form-item>
          <el-button
            type="primary"
            @click="
              formVisible = false
              mainpageVisible = true
              createLearningJourney(editableTabsValue)
            "
            >Next</el-button
          >
        </el-form-item>
      </el-form>
    </div>
    <!-- create LJ -->
    <el-dialog
      :visible.sync="createLJSuccessVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-success"></i><span>{{ createLJSuccessMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <el-dialog
      :visible.sync="createLJFailVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-error"></i><span>{{ createLJFailMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <!-- delete LJ -->
    <el-dialog
      :visible.sync="deleteLJSuccessVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-success"></i><span>{{ deleteLJSuccessMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <el-dialog
      :visible.sync="deleteLJFailVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-error"></i><span>{{ deleteLJFailMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <!-- edit LJ -->
    <el-dialog
      :visible.sync="updateLJSuccessVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-success"></i><span>{{ updateLJSuccessMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <el-dialog
      :visible.sync="updateLJFailVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-error"></i><span>{{ updateLJFailMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <!-- Register -->
    <el-dialog
      :visible.sync="registerSuccessVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-success"></i><span>{{ registerSuccessMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <el-dialog
      :visible.sync="registerFailVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-error"></i><span>{{ registerFailMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <!-- Start LJ -->
    <el-dialog
      :visible.sync="startLJSuccessVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-success"></i><span>{{ startLJSuccessMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
    <el-dialog
      :visible.sync="startLJFailVisible"
      width="30%"
      center
      @close="reloadPage()"
    >
      <br /><br /><br /><br />
      <div class="success-message">
        <i class="el-icon-error"></i><span>{{ startLJFailMessage }}</span>
      </div>
      <br /><br /><br /><br /><br /><br />
    </el-dialog>
  </div>
</template>

<script>
const axios = require('axios').default
export default {
  components: {},
  data() {
    return {
      editLjVisible: false,
      ljStartSuccessVisible: false,
      editableTabsValue: '0',
      editableTabs: [],
      tabIndex: 0,
      formVisible: false,
      deleteLJformVisible: false,
      mainpageVisible: true,
      formLearningJourney: {
        roleChosen: ''
      },
      DeleteLJForm: {
        RoleNameToDelete: ''
      },
      courses: this.getAllCourses(),
      roles: this.getAllRoles(),
      skills: this.getAllSkills(),
      roleskill: this.getRoleSkill(),
      courseskill: this.getCourseSkill(),
      learningjourneys: this.getLearningJourneys(),
      LJcourse: this.LearningJourneyHasCourse(),
      courseIDtoBeAdded: '',
      roleIDtoBeAdded: '',
      createLJSuccessMessage: '',
      createLJSuccessVisible: false,
      createLJFailMessage: '',
      createLJFailVisible: false,
      deleteLJSuccessMessage: '',
      deleteLJSuccessVisible: false,
      deleteLJFailMessage: '',
      deleteLJFailVisible: false,
      registerSuccessMessage: '',
      registerSuccessVisible: false,
      registerFailMessage: '',
      registerFailVisible: false,
      startLJSuccessMessage: '',
      startLJSuccessVisible: false,
      startLJFailMessage: '',
      startLJFailVisible: false,
      updateLJSuccessMessage: '',
      updateLJSuccessVisible: false,
      updateLJFailMessage: '',
      updateLJFailVisible: false
    }
  },
  methods: {
    consolelog() {
      console.log(this.editableTabs)
      console.log(this.learningjourneys)
      console.log(this.LJcourse)
    },
    checkRoleChosen(value) {
      console.log(value)
      console.log(this.formLearningJourney.roleChosen)
    },
    checkChosen(value) {
      console.log(value)
    },
    // addRole(targetName) {
    //   const skillsOfRole = []
    //   const recommendedCourses = []
    //   // const newTabName = ++this.tabIndex + ''
    //   for (const role of this.roles) {
    //     if (role.role_name === this.formLearningJourney.roleChosen) {
    //       for (const roleskillpair of this.roleskill) {
    //         if (roleskillpair.roleID === role.role_id) {
    //           skillsOfRole.push(roleskillpair.skillName)
    //           console.log(skillsOfRole)
    //         }
    //       }
    //     }
    //   }

    //   for (const course of this.courses) {
    //     let toAddCourse = false
    //     for (const courseskillpair of this.courseskill) {
    //       if (courseskillpair.cid === course.course_ID) {
    //         for (const filterSkill of skillsOfRole) {
    //           if (courseskillpair.sNAME === filterSkill) {
    //             toAddCourse = true
    //           }
    //           if (toAddCourse === true) {
    //             recommendedCourses.push(course)
    //           }
    //         }
    //       }
    //     }
    //   }
    //   console.log(recommendedCourses)
    //   this.editableTabs.push({
    //     title: this.formLearningJourney.roleChosen,
    //     content: 'New role added',
    //     skillsOfRole: skillsOfRole,
    //     recommendedCourses: recommendedCourses,
    //     myCourses: []
    //   })
    //   // this.editableTabsValue = newTabName
    // },
    removeTab(targetName) {
      const tabs = this.editableTabs
      let activeName = this.editableTabsValue
      if (activeName === targetName) {
        tabs.forEach((tab, index) => {
          if (tab.name === targetName) {
            const nextTab = tabs[index + 1] || tabs[index - 1]
            console.log(index)
            if (nextTab) {
              activeName = nextTab.name
            }
          }
        })
      }
      this.editableTabsValue = activeName
      this.editableTabs = tabs.filter((tab) => tab.name !== targetName)
    },
    async getAllRoles() {
      await axios
        .get('http://localhost:8080/AllRole')
        .then((response) => (this.roles = response.data))
    },
    async getAllSkills() {
      await axios
        .get('http://localhost:8080/AllSkill')
        .then((response) => (this.skills = response.data))
    },
    async getAllCourses() {
      await axios
        .get('http://localhost:8080/all_course')
        .then((response) => (this.courses = response.data))
    },
    async getRoleSkill() {
      console.log('hello')
      await axios
        .get('http://localhost:8080/all_role_skill')
        .then((response) => (this.roleskill = response.data))
    },
    async getCourseSkill() {
      console.log('hello')
      await axios
        .get('http://localhost:8080/all_course_skill')
        .then((response) => (this.courseskill = response.data))
    },
    async getLearningJourneys() {
      const LJcourse = this.LearningJourneyHasCourse()
      await axios
        .get('http://localhost:8080/allLearningJourney')
        .then((response) => (this.learningjourneys = response.data))
      for (const LJ of this.learningjourneys) {
        const skillsOfRole = []
        const recommendedCourses = []
        const shoppingCart = []
        let roleIsActive = true
        // let skillIsActive = true
        // for (const skill of this.skills) {
        //   if(skill.skill_ID === l)
        // }
        for (const role of this.roles) {
          if (role.role_id === LJ.role_ID) {
            if (role.status === 0) {
              roleIsActive = false
            }
          }
        }
        for (const course of this.courses) {
          let toAddCourse = false
          for (const LJcoursePair of this.LJcourse) {
            if (LJcoursePair.courseID === course.course_ID) {
              if (LJcoursePair.ljid === LJ.lj_ID) {
                toAddCourse = true
              }
            }
          }
          if (toAddCourse === true) {
            shoppingCart.push(course)
          }
        }
        for (const role of this.roles) {
          if (role.role_id === LJ.role_ID) {
            for (const roleskillpair of this.roleskill) {
              if (roleskillpair.roleID === role.role_id) {
                skillsOfRole.push(roleskillpair.skillName)
              }
            }
          }
        }
        for (const course of this.courses) {
          let toAddCourse = false
          for (const courseskillpair of this.courseskill) {
            if (courseskillpair.cid === course.course_ID) {
              for (const filterSkill of skillsOfRole) {
                if (courseskillpair.sNAME === filterSkill) {
                  toAddCourse = true
                }
              }
            }
          }
          if (toAddCourse === true) {
            recommendedCourses.push(course)
          }
        }
        await this.editableTabs.push({
          title: LJ.role_Name,
          roleID: LJ.role_ID,
          roleStatus: roleIsActive,
          LearningJourneyID: LJ.lj_ID,
          content: 'New role added',
          skillsOfRole: skillsOfRole,
          recommendedCourses: recommendedCourses,
          myCourses: shoppingCart
        })
      }
      console.log(this.editableTabs)
    },
    // createLJSuccessMessage: '',
    //   createLJSuccessVisible: false,
    //   createLJFailMessage: '',
    //   createLJFailVisible: false
    async createLearningJourney(targetName) {
      const newTabName = ++this.tabIndex + ''
      await axios
        .post('http://localhost:8080/createLearningJourney', {
          staff_id: 130001,
          role_id: this.formLearningJourney.roleChosen
        })
        .then((response) => {
          if (response.data.slice(0, 3) === 'The') {
            this.createLJFailMessage = response.data
            this.createLJFailVisible = true
          } else {
            this.createLJSuccessMessage = response.data
            this.createLJSuccessVisible = true
          }
        })
      this.editableTabsValue = newTabName
    },
    // id 를 0으로 아무것도 없으면
    // deleteLJSuccessMessage: '',
    //   deleteLJSuccessVisible: false,
    //   deleteLJFailMessage: '',
    //   deleteLJFailVisible: false
    // await axios
    //   .delete(
    //     'http://localhost:8080/deleteLearningJourney/' +
    //       this.DeleteLJForm.RoleNameToDelete
    async deleteLearningJourney(targetName) {
      const newTabName = ++this.tabIndex + ''
      if (this.DeleteLJForm.RoleNameToDelete === '') {
        await axios
          .post('http://localhost:8080/deleteLearningJourney/' + '0')
          .then((response) => {
            this.deleteLJFailMessage = response.data
            this.deleteLJFailVisible = true
          })
      } else {
        await axios
          .post(
            'http://localhost:8080/deleteLearningJourney/' +
              this.DeleteLJForm.RoleNameToDelete
          )
          .then((response) => {
            console.log(response.data)
            if (response.data.slice(0, 12) === 'Successfully') {
              this.deleteLJSuccessMessage = response.data
              this.deleteLJSuccessVisible = true
              // 새로운것
            } else {
              this.deleteLJFailMessage = response.data
              this.deleteLJFailVisible = true
            }
          })
      }
      this.editableTabsValue = newTabName
    },
    async LearningJourneyHasCourse() {
      console.log('hello')
      await axios
        .get('http://localhost:8080/allLJ_has_course')
        .then((response) => (this.LJcourse = response.data))
    },
    async addCourse(roleID, courseID) {
      console.log(roleID)
      console.log(courseID)
      await axios
        .post('http://localhost:8080/addCourse', {
          role_id: roleID,
          course_id: courseID
        })
        .then((response) => {
          if (response.data.slice(0, 12) === 'Successfully') {
            console.log(response.data)
            this.updateLJSuccessMessage = response.data
            this.updateLJSuccessVisible = true
          } else {
            this.updateLJFailMessage = response.data
            this.updateLJFailVisible = true
          }
        })
    },
    async removeCourse(roleID, courseID) {
      await axios
        .post('http://localhost:8080/removeCourse', {
          role_id: roleID,
          course_id: courseID
        })
        .then((response) => {
          if (response.data.slice(0, 3) === 'You') {
            this.updateLJFailMessage = response.data
            this.updateLJFailVisible = true
          } else {
            this.updateLJSuccessMessage = response.data
            this.updateLJSuccessVisible = true
          }
        })
    },
    async registerCourse(courseID) {
      await axios
        .post('http://localhost:8080/registerCourse', {
          course_id: courseID,
          staff_id: 130001
        })
        .then((response) => {
          if (response.data.slice(0, 12) === 'Successfully') {
            console.log(response.data)
            this.registerSuccessMessage = response.data
            this.registerSuccessVisible = true
          } else {
            this.registerFailMessage = response.data
            this.registerFailVisible = true
          }
        })
    },
    async startLearningJourney(learningJourneyID) {
      await axios
        .post('http://localhost:8080/startLearningJourney/' + learningJourneyID)
        .then((response) => {
          if (response.data.slice(0, 12) === 'Successfully') {
            console.log(response.data)
            this.startLJSuccessMessage = response.data
            this.startLJSuccessVisible = true
          } else if (response.data.slice(0, 3) === 'You') {
            this.startLJFailMessage = response.data
            this.startLJFailVisible = true
          } else {
            this.startLJFailMessage = response.data
            this.startLJFailVisible = true
          }
        })
    },
    reloadPage() {
      location.reload()
    }
  }
}
</script>

<style>
.lj-start-button {
  float: right;
}
label.el-radio.black-text {
  color: black !important;
  font-size: 1em;
  margin-right: 100px;
}

div.roleSelect {
  background-color: #f5f5f7;
  text-align: center;
  font-size: 2em;
  padding: 300px;
}

#LJ-bar {
  background-color: #f1f1f1;
  color: black;
  padding: 10px;
}

.margin-box {
  margin: 20px;
}

div.scroll-bar-lj {
  height: 320px !important;
  width: 1000px !important;
  overflow: scroll !important;
}

.course-card {
  margin: 20px !important;
}

.course-status {
  float: right !important;
}

.edit-my-courses {
  float: right !important;
}

div.success-message {
  text-align: center !important;
  font-size: 40px !important;
}

i.el-icon-success {
  color: green !important;
}

i.el-icon-error {
  color: red !important;
}

.staff-learningjourney {
  background-color: #f5f5f7;
  margin: auto;
  width: auto;
  height: 1000px;
}

.black-text {
  color: black !important;
}

.el-card {
  height: 400px !important;
}
</style>
