<template>
  <div>
    <el-row>
      <el-col :span="3">
        <div id="filter-by">
          <div class="margin-box">
            <h3>Filter By</h3>
            <br />
            <h4>Roles</h4>
            <br />
            <el-dialog
              title="Edit Role"
              :visible.sync="EditRoleVisible"
              width="35%"
              name="roleFilters"
            >
              <el-form :model="EditRoleForm">
                <el-form-item label="Role to Edit:">
                  <el-select
                    v-model="EditRoleForm.roleToEdit"
                    placeholder="please select role to Edit"
                  >
                    <span :key="role.role_id" v-for="role in roles">
                      <span v-if="role.status === 1">
                        <el-option
                          :label="role.role_name"
                          :value="role.role_id"
                        >
                        </el-option>
                      </span>
                    </span>
                  </el-select>
                </el-form-item>
                <el-form-item label="Name:">
                  <el-input
                    v-model="EditRoleForm.newRoleName"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
                <el-form-item label="Description:">
                  <el-input
                    v-model="EditRoleForm.newRoleDesc"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
                <el-form-item label="Skills Acquired:">
                  <el-checkbox-group v-model="EditRoleForm.newRoleSkills">
                    <span v-for="skill in skills" :key="skill.skill_ID">
                      <span v-if="skill.skill_Is_Active === 1">
                        <el-checkbox class="black-text" :label="skill.skill_ID"
                          ><template slot="default">{{
                            skill.skill_Name
                          }}</template></el-checkbox
                        >
                      </span>
                    </span>
                  </el-checkbox-group>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button
                  @click="
                    EditRoleVisible = false
                    deleteRoles()
                  "
                  >Delete</el-button
                >
                <el-button
                  type="primary"
                  @click="
                    EditRoleVisible = false
                    editRoles()
                  "
                  >Update</el-button
                >
              </span>
            </el-dialog>
            <el-dialog
              title="Create Role"
              :visible.sync="CreateRoleVisible"
              width="35%"
              name="roleFilters"
            >
              <el-form :model="CreateRoleForm">
                <el-form-item label="Name:">
                  <el-input
                    v-model="CreateRoleForm.newRoleName"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
                <el-form-item label="Description:">
                  <el-input
                    v-model="CreateRoleForm.newRoleDesc"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button @click="CreateRoleVisible = false">Cancel</el-button>
                <el-button
                  type="primary"
                  @click="
                    CreateRoleVisible = false
                    createRoles()
                  "
                  >Create</el-button
                >
              </span>
            </el-dialog>
            <br />
            <div class="filter-role">
              <el-radio-group
                v-model="formFilter.roleFilters"
                @change="checkFilterRole"
              >
                <div v-for="role in roles" :key="role.label" class="white-text">
                  <div v-if="role.status === 1">
                    <el-tooltip :visible="visible" placement="right">
                      <template #content>
                        <span>Description: {{ role.role_description }}</span>
                        <br />
                        Skills:
                        <ul v-for="skill in roleskill" :key="skill.skillID">
                          <li v-if="skill.roleID === role.role_id">
                            {{ skill.skillName }}
                          </li>
                        </ul>
                      </template>
                      <el-radio
                        :label="role.role_name"
                        name="roleFilters"
                        class="white-text"
                      ></el-radio>
                    </el-tooltip>
                  </div>
                </div>
              </el-radio-group>
            </div>
            <br />
            <el-button type="text" @click="dialogRoleVisible = true">
              <div class="white-text">show all</div>
            </el-button>
            <el-dialog
              title="Roles"
              :visible.sync="dialogRoleVisible"
              width="35%"
            >
              <el-form :model="formFilter">
                <el-form-item label="">
                  <el-radio-group
                    v-model="formFilter.roleFilters"
                    @change="checkFilterRole"
                  >
                    <span v-for="role in roles" :key="role.label">
                      <span v-if="role.status === 1">
                        <el-tooltip :visible="visible" placement="right">
                          <template #content>
                            <span
                              >Description: {{ role.role_description }}</span
                            >
                            <br />
                            Skills:
                            <div
                              v-for="skill in roleskill"
                              :key="skill.skillID"
                            >
                              <span v-if="skill.roleID === role.role_id">
                                {{ skill.skillName }}
                              </span>
                            </div>
                          </template>
                          <el-radio
                            class="black-text"
                            :label="role.role_name"
                            name="roleFilters"
                          ></el-radio>
                        </el-tooltip>
                      </span>
                    </span>
                  </el-radio-group>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button @click="dialogRoleVisible = false">Clear</el-button>
                <el-button type="primary" @click="dialogRoleVisible = false"
                  >Apply</el-button
                >
              </span>
            </el-dialog>
            <br /><br />
            <h4>Skills</h4>
            <br />
            <el-dialog
              title="Edit Skill"
              :visible.sync="EditSkillVisible"
              width="35%"
              name="skillFilters"
            >
              <el-form :model="EditSkillForm">
                <el-form-item label="Skill to Edit:">
                  <el-select
                    v-model="EditSkillForm.skillToEdit"
                    placeholder="please select skill to Edit"
                  >
                    <span :key="skill.skill_ID" v-for="skill in skills">
                      <span v-if="skill.skill_Is_Active === 1">
                        <el-option
                          :label="skill.skill_Name"
                          :value="skill.skill_ID"
                        >
                        </el-option>
                      </span>
                    </span>
                  </el-select>
                </el-form-item>
                <el-form-item label="Name:">
                  <el-input
                    v-model="EditSkillForm.newSkillName"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
                <el-form-item label="Description:">
                  <el-input
                    v-model="EditSkillForm.newSkillDesc"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button
                  @click="
                    EditSkillVisible = false
                    deleteSkills()
                  "
                  >Delete</el-button
                >
                <el-button
                  type="primary"
                  @click="
                    EditSkillVisible = false
                    editSkills()
                  "
                  >Update</el-button
                >
              </span>
            </el-dialog>
            <el-dialog
              title="Create Skill"
              :visible.sync="CreateSkillVisible"
              width="35%"
              name="skillFilters"
            >
              <el-form :model="CreateSkillForm">
                <el-form-item label="Name:">
                  <el-input
                    v-model="CreateSkillForm.newSkillName"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
                <el-form-item label="Description:">
                  <el-input
                    v-model="CreateSkillForm.newSkillDesc"
                    autocomplete="off"
                  ></el-input>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button @click="CreateSkillVisible = false"
                  >Cancel</el-button
                >
                <el-button
                  type="primary"
                  @click="
                    CreateSkillVisible = false
                    createSkills()
                  "
                  >Create</el-button
                >
              </span>
            </el-dialog>
            <br />
            <div class="filter-skill">
              <el-checkbox-group
                v-model="formFilter.skillFilters"
                @change="checkFilterSkill"
              >
                <div
                  v-for="skill in skills"
                  :key="skill.skill_Name"
                  class="white-text"
                >
                  <div v-if="skill.skill_Is_Active === 1">
                    <el-tooltip :visible="visible" placement="right">
                      <template #content>
                        <span>Description: {{ skill.skill_Des }}</span>
                      </template>
                      <el-checkbox
                        :label="skill.skill_Name"
                        name="skillFilters"
                        class="white-text"
                      ></el-checkbox>
                    </el-tooltip>
                  </div>
                </div>
              </el-checkbox-group>
            </div>
            <br /><br />
            <el-button type="text" @click="dialogSkillVisible = true">
              <div class="white-text">show all</div>
            </el-button>
            <el-dialog
              title="Skills"
              :visible.sync="dialogSkillVisible"
              width="35%"
            >
              <el-form :model="formFilter">
                <el-form-item label="">
                  <el-checkbox-group
                    v-model="formFilter.skillFilters"
                    @change="checkFilterSkill"
                  >
                    <span v-for="skill in skills" :key="skill.skill_Name">
                      <span v-if="skill.skill_Is_Active === 1">
                        <el-tooltip :visible="visible" placement="right">
                          <template #content>
                            <span>Description: {{ skill.skill_Des }}</span>
                          </template>
                          <el-checkbox
                            class="black-text"
                            :label="skill.skill_Name"
                            name="skillFilters"
                          ></el-checkbox>
                        </el-tooltip>
                      </span>
                    </span>
                  </el-checkbox-group>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button @click="dialogSkillVisible = false">Clear</el-button>
                <el-button type="primary" @click="dialogSkillVisible = false"
                  >Apply</el-button
                >
              </span>
            </el-dialog>
          </div>
        </div>
      </el-col>
      <el-col :span="21">
        <div class="scroll-bar">
          <el-row>
            <el-col :span="8" v-for="item in courses" :key="item">
              <div class="course-card" v-if="item.course_Is_Active === 1">
                <el-card :body-style="{padding: '0px'}" shadow="always">
                  <div style="padding: 14px">
                    <h4>Course ID: {{ item.course_ID }}</h4>
                    <h3>{{ item.course_Name }}</h3>
                    <br />
                    Skills:
                    <ul v-for="cskill in courseskill" :key="cskill.id">
                      <li v-if="cskill.cid === item.course_ID">
                        {{ cskill.sNAME }}
                      </li>
                    </ul>
                    <br />
                    <span>Category: {{ item.course_Category }}</span>
                    <br />
                    <span>Desc: {{ item.course_Desc }}</span>
                    <div class="bottom clearfix">
                      <span>Course Type : {{ item.course_Type }}</span>
                      <span class="course-status"
                        >Status:{{ item.course_Status }}</span
                      >
                    </div>
                  </div>
                </el-card>
              </div>
            </el-col>
          </el-row>
        </div>
      </el-col>
      <el-dialog
        title="Edit Course"
        :visible.sync="EditCourseVisible"
        width="35%"
        name="courseUpdate"
      >
        <el-form :model="EditCourseForm">
          <el-form-item label="Course to Edit:">
            <el-select
              v-model="EditCourseForm.courseToEditId"
              placeholder="please select course ID to Edit"
            >
              <el-option
                :key="course.course_ID"
                v-for="course in courses"
                :label="course.course_Name"
                :value="course.course_ID"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="New Skills for This Course">
            <el-checkbox-group v-model="EditCourseForm.newCourseSkills">
              <span v-for="skill in skills" :key="skill.skill_ID">
                <span v-if="skill.skill_Is_Active === 1">
                  <el-checkbox class="black-text" :label="skill.skill_ID"
                    ><template slot="default">{{
                      skill.skill_Name
                    }}</template></el-checkbox
                  >
                </span>
              </span>
            </el-checkbox-group>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="EditCourseVisible = false">Cancel</el-button>
          <el-button
            type="primary"
            @click="
              EditCourseVisible = false
              editCourses()
            "
            >Update</el-button
          >
        </span>
      </el-dialog>
      <!-- skill creation -->
      <el-dialog
        :visible.sync="SuccessSkillCreationDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i
          ><span>{{ skillCreationSuccessMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="ErrorSkillCreationDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i
          ><span>{{ skillCreationErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="ErrorskillCreation50Visible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i
          ><span>{{ skillCreationMoreThan50ErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <!-- skill update -->
      <el-dialog
        :visible.sync="SuccessSkillUpdateDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i
          ><span>{{ skillUpdateSuccessMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="ErrorSkillUpdateDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i
          ><span>{{ skillUpdateErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="ErrorskillUpdate50Visible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i
          ><span>{{ skillUpdateMoreThan50ErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <!-- role create -->
      <el-dialog
        :visible.sync="SuccessRoleCreationDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i
          ><span>{{ roleCreationSuccessMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="ErrorRoleCreationDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i
          ><span>{{ roleCreationErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="ErrorroleCreation50Visible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i
          ><span>{{ roleCreationMoreThan50ErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <!-- role update -->
      <el-dialog
        :visible.sync="roleUpdateSucessMessageVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i
          ><span>{{ roleUpdateSucessMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="roleUpdateErrorVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i><span>{{ roleUpdateErrorMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <!-- role deletion -->
      <el-dialog
        :visible.sync="SuccessRoleDeleteDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i
          ><span>{{ roleDeleteSuccessMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <!-- skill deletion -->
      <el-dialog
        :visible.sync="SuccessSkillDeleteDialogVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i
          ><span>{{ skillDeleteSuccessMessage }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <!-- Course Update -->
      <el-dialog
        :visible.sync="courseUpdateSuccessVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-success"></i><span>{{ courseUpdateSuccess }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
      <el-dialog
        :visible.sync="courseUpdateFailVisible"
        width="30%"
        center
        @close="reloadPage()"
      >
        <br /><br /><br /><br />
        <div class="success-message">
          <i class="el-icon-error"></i><span>{{ courseUpdateFail }}</span>
        </div>
        <br /><br /><br /><br /><br /><br />
      </el-dialog>
    </el-row>
  </div>
</template>
<script>
// <vue-scroll-snap :fullscreen="true"> -- in html
const axios = require('axios').default
export default {
  components: {},
  data() {
    return {
      SuccessRoleDeleteDialogVisible: false,
      roleDeleteSuccessMessage: '',
      SuccessSkillDeleteDialogVisible: false,
      skillDeleteSuccessMessage: '',
      SuccessRoleCreationDialogVisible: false,
      ErrorRoleCreationDialogVisible: false,
      ErrorroleCreation50Visible: false,
      roleCreationSuccessMessage: '',
      roleCreationErrorMessage: '',
      roleCreationMoreThan50ErrorMessage: '',
      SuccessRoleUpdateDialogVisible: false,
      ErrorRoleUpdateDialogVisible: false,
      ErrorroleUpdate50Visible: false,
      roleUpdateMoreThan50ErrorMessage: '',
      SuccessSkillCreationDialogVisible: false,
      ErrorSkillCreationDialogVisible: false,
      ErrorskillCreation50Visible: false,
      skillCreationSuccessMessage: '',
      skillCreationErrorMessage: '',
      skillCreationMoreThan50ErrorMessage: '',
      SuccessSkillUpdateDialogVisible: false,
      ErrorSkillUpdateDialogVisible: false,
      ErrorskillUpdate50Visible: false,
      skillUpdateSuccessMessage: '',
      skillUpdateErrorMessage: '',
      skillUpdateMoreThan50ErrorMessage: '',
      CreateRoleVisible: false,
      CreateSkillVisible: false,
      EditRoleVisible: false,
      EditSkillVisible: false,
      EditCourseVisible: false,
      dialogRoleVisible: false,
      dialogSkillVisible: false,
      roleUpdateRoleUnchangedSuccessMessage: '',
      SuccessroleUpdateRoleUnchangedVisible: false,
      roleUpdateSuccessSkillUnassignedMessage: '',
      SuccessroleUpdateSuccessSkillUnassignedVisible: false,
      roleUpdateRoleNotSelectedMessage: '',
      ErrorRoleUpdateRoleNotSelectedVisible: false,
      roleUpdateErrorMessage: '',
      roleUpdateErrorVisible: false,
      roleUpdateSucessMessage: '',
      roleUpdateSucessMessageVisible: false,
      courseUpdateSuccess: '',
      courseUpdateSuccessVisible: false,
      courseUpdateFail: '',
      courseUpdateFailVisible: false,
      count: 0,
      courses: this.getAllCourses(),
      // courses: [
      //   {
      //     course_id: 1,
      //     course_name: 'Creating Awesome Mobile Apps',
      //     course_desc: 'Learn how to create awesome mobile applications!',
      //     course_status: 'not started',
      //     course_type: 'online',
      //     course_category: 'Mobile app development',
      //     skills: ['coding', 'Selenium'],
      //     visibility: true
      //   },
      //   {
      //     course_id: 2,
      //     course_name: 'Managing software project',
      //     course_desc: 'You will become project management GOD!',
      //     course_status: 'not started',
      //     course_type: 'offline',
      //     course_category: 'Agile Methodology',
      //     skills: ['JIRA'],
      //     visibility: true
      //   },
      //   {
      //     course_id: 3,
      //     course_name: 'Creating Awesome Mobile Apps',
      //     course_desc: 'Learn how to create awesome mobile applications!',
      //     course_status: 'not started',
      //     course_type: 'online',
      //     course_category: 'Mobile app development',
      //     skills: ['coding'],
      //     visibility: true
      //   },
      //   {
      //     course_id: 4,
      //     course_name: 'Creating Awesome Mobile Apps',
      //     course_desc: 'Learn how to create awesome mobile applications!',
      //     course_status: 'not started',
      //     course_type: 'online',
      //     course_category: 'Mobile app development',
      //     skills: ['Selenium'],
      //     visibility: true
      //   },
      //   {
      //     course_id: 5,
      //     course_name: 'Creating Awesome Mobile Apps',
      //     course_desc: 'Learn how to create awesome mobile applications!',
      //     course_status: 'not started',
      //     course_type: 'online',
      //     course_category: 'Mobile app development',
      //     skills: ['Figma', 'coding', 'JIRA', 'Selenium'],
      //     visibility: true
      //   },
      //   {
      //     course_id: 6,
      //     course_name: 'Creating Awesome Mobile Apps',
      //     course_desc: 'Learn how to create awesome mobile applications!',
      //     course_status: 'not started',
      //     course_type: 'online',
      //     course_category: 'Mobile app development',
      //     skills: ['Figma', 'coding', 'JIRA', 'Selenium'],
      //     visibility: true
      //   }
      // ],
      roles: this.getAllRoles(),
      skills: this.getAllSkills(),
      roleskill: this.getRoleSkill(),
      courseskill: this.getCourseSkill(),
      // [
      //   { label: 'Figma', description: '' },
      //   { label: 'coding', description: '' },
      //   { label: 'JIRA', description: '' },
      //   { label: 'Selenium', description: '' }
      // ],
      formFilter: {
        roleFilters: 'he',
        skillFilters: []
      },
      formInline: {
        input_course: ''
      },
      CreateRoleForm: {
        newRoleName: '',
        newRoleDesc: ''
      },
      CreateSkillForm: {
        newSkillName: '',
        newSkillDesc: ''
      },
      EditRoleForm: {
        roleToEdit: '',
        newRoleName: '',
        newRoleDesc: '',
        newRoleSkills: []
      },
      EditSkillForm: {
        skillToEdit: '',
        newSkillName: '',
        newSkillDesc: ''
      },
      EditCourseForm: {
        courseToEditId: '',
        newCourseSkills: []
      }
    }
  },
  methods: {
    updateRole() {
      console.log(this.EditRoleForm.roleToEdit)
      console.log('hello')
      for (const role of this.roles) {
        if (role.label === this.EditRoleForm.roleToEdit) {
          role.label = this.EditRoleForm.newRoleName
          role.description = this.EditRoleForm.newRoleDesc
          role.skills = this.EditRoleForm.newRoleSkills
        }
      }
    },
    updateCourse() {
      for (const key in this.courses) {
        if (
          this.courses[key].course_id === this.EditCourseForm.courseToEditId
        ) {
          this.courses[key].skills = this.EditCourseForm.newCourseSkills
        }
      }
    },
    createRole() {
      this.roles.push({
        label: this.CreateRoleForm.newRoleName,
        skills: [],
        description: this.CreateRoleForm.newRoleDesc
      })
    },
    updateSkill() {
      for (const skill of this.skills) {
        if (skill.label === this.EditSkillForm.skillToEdit) {
          skill.label = this.EditSkillForm.newSkillName
          skill.description = this.EditSkillForm.newSkillDesc
        }
      }
    },
    createSkill() {
      // asdf
      this.skills.push({
        label: this.CreateSkillForm.newSkillName,
        description: this.CreateSkillForm.newSkillDesc
      })
    },
    deleteRole() {
      for (let i = 0; i < this.roles.length; i++) {
        if (this.roles[i].label === this.EditRoleForm.roleToEdit) {
          this.roles.splice(i, 1)
        }
      }
    },
    deleteSkill() {
      for (let i = 0; i < this.skills.length; i++) {
        if (this.skills[i].label === this.EditSkillForm.skillToEdit) {
          this.skills.splice(i, 1)
        }
      }
    },
    checkFilterRole(value) {
      console.log(value)
      const filterSkills = []
      for (const role of this.roles) {
        if (role.role_name === value) {
          for (const roleskillpair of this.roleskill) {
            if (roleskillpair.roleID === role.role_id) {
              filterSkills.push(roleskillpair.skillID)
            }
          }
        }
      }
      console.log(filterSkills)
      for (const course of this.courses) {
        course.course_Is_Active = 0
        for (const courseskillpair of this.courseskill) {
          if (courseskillpair.cid === course.course_ID) {
            for (const filterSkill of filterSkills) {
              if (courseskillpair.sid === filterSkill) {
                course.course_Is_Active = 1
              }
            }
          }
        }
        this.formFilter.skillFilters = []
        for (const role of this.roles) {
          if (role.role_name === value) {
            for (const roleskillpair of this.roleskill) {
              if (roleskillpair.roleID === role.role_id) {
                this.formFilter.skillFilters.push(roleskillpair.skillName)
              }
            }
            // console.log(role.skills)
            // console.log(this.formFilter.skillFilters)
            console.log(this.formFilter.skillFilters)
          }
        }
      }
    },
    checkFilterSkill(value) {
      console.log(value)
      this.formFilter.roleFilters = ''
      for (const course of this.courses) {
        course.course_Is_Active = 0
        for (const courseskillpair of this.courseskill) {
          if (courseskillpair.cid === course.course_ID) {
            for (const filterSkill of value) {
              if (courseskillpair.sNAME === filterSkill) {
                course.course_Is_Active = 1
              }
            }
          }
        }
      }
      console.log(this.formFilter.roleFilters)
    },
    async getAllRoles() {
      axios
        .get('http://localhost:8080/AllRole')
        .then((response) => (this.roles = response.data))
    },
    async getAllSkills() {
      axios
        .get('http://localhost:8080/AllSkill')
        .then((response) => (this.skills = response.data))
    },
    async getAllCourses() {
      axios
        .get('http://localhost:8080/all_course')
        .then((response) => (this.courses = response.data))
    },
    async getSkillsOfRole(RoleId) {
      console.log('hello')
      await axios
        .get('http://localhost:8080/getRolesRelatedSkills/' + RoleId)
        .then((response) => console.log(response.data))
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
    async createSkills() {
      await axios
        .post('http://localhost:8080/CreateSkill', {
          skill_name: this.CreateSkillForm.newSkillName,
          skill_des: this.CreateSkillForm.newSkillDesc
        })
        .then((response) => {
          if (response.data.slice(0, 12) === 'Successfully') {
            console.log(response.data.slice(0, 12))
            this.skillCreationSuccessMessage = response.data
            this.SuccessSkillCreationDialogVisible = true
          } else if (response.data.slice(0, 4) === 'Name') {
            this.skillCreationMoreThan50ErrorMessage = response.data
            this.ErrorskillCreation50Visible = true
          } else if (response.data.slice(0, 12) === 'Skill name s') {
            this.skillCreationMoreThan50ErrorMessage = response.data
            this.ErrorskillCreation50Visible = true
          } else {
            console.log(response.data.slice(0, 12))
            this.skillCreationErrorMessage = response.data
            this.ErrorSkillCreationDialogVisible = true
          }
        })
    },
    async createRoles() {
      await axios
        .post('http://localhost:8080/CreateRole', {
          role_name: this.CreateRoleForm.newRoleName,
          role_description: this.CreateRoleForm.newRoleDesc
        })
        .then((response) => {
          if (response.data.slice(0, 12) === 'Successfully') {
            console.log(response.data.slice(0, 12))
            this.roleCreationSuccessMessage = response.data
            this.SuccessRoleCreationDialogVisible = true
          } else if (response.data.slice(0, 4) === 'Name') {
            this.roleCreationMoreThan50ErrorMessage = response.data
            this.ErrorroleCreation50Visible = true
          } else if (response.data.slice(0, 12) === 'Role name sh') {
            this.roleCreationMoreThan50ErrorMessage = response.data
            this.ErrorroleCreation50Visible = true
          } else {
            console.log(response.data.slice(0, 12))
            this.roleCreationErrorMessage = response.data
            // location.reload()
            this.ErrorRoleCreationDialogVisible = true
          }
        })
    },
    async editRoles() {
      console.log(this.EditRoleForm.newRoleSkills)
      console.log(this.EditRoleForm.roleToEdit)
      if (this.EditRoleForm.roleToEdit === '') {
        await axios
          .post('http://localhost:8080/editRole', {
            id: 0,
            name: this.EditRoleForm.newRoleName,
            des: this.EditRoleForm.newRoleDesc,
            list: this.EditRoleForm.newRoleSkills
          })
          .then((response) => {
            this.roleUpdateErrorMessage = response.data
            this.roleUpdateErrorVisible = true
          })
      } else {
        await axios
          .post('http://localhost:8080/editRole', {
            id: this.EditRoleForm.roleToEdit,
            name: this.EditRoleForm.newRoleName,
            des: this.EditRoleForm.newRoleDesc,
            list: this.EditRoleForm.newRoleSkills
          })
          .then((response) => {
            if (response.data.slice(0, 21) === 'Successfully Assigned') {
              console.log(response.data.slice(0, 21))
              this.roleUpdateSucessMessage = response.data
              this.roleUpdateSucessMessageVisible = true
              // 새로운것
            } else if (response.data.slice(0, 7) === 'Updated') {
              this.roleUpdateSucessMessage = response.data
              this.roleUpdateSucessMessageVisible = true
              // 새로운것
            } else if (response.data.slice(0, 20) === 'Successfully Updated') {
              this.roleUpdateSucessMessage = response.data
              this.roleUpdateSucessMessageVisible = true
            } else if (response.data.slice(0, 12) === 'Role name sh') {
              this.roleUpdateErrorMessage = response.data
              this.roleUpdateErrorVisible = true
            } else if (response.data.slice(0, 6) === 'Please') {
              this.roleUpdateErrorMessage = response.data
              this.roleUpdateErrorVisible = true
              // 새로운것
            } else {
              console.log(response.data.slice(0, 12))
              this.roleUpdateSucessMessage = response.data
              // location.reload()
              this.roleUpdateSucessMessageVisible = true
            }
          })
      }
    },
    async deleteRoles() {
      await axios
        .post(
          'http://localhost:8080/DeleteRole/' + this.EditRoleForm.roleToEdit
        )
        .then((response) => {
          this.roleDeleteSuccessMessage = response.data
          this.SuccessRoleDeleteDialogVisible = true
        })
    },
    async editSkills() {
      if (this.EditSkillForm.skillToEdit === '') {
        await axios
          .post('http://localhost:8080/UpdateSkill', {
            skill_id: 0,
            skill_name: this.EditSkillForm.newSkillName,
            skill_des: this.EditSkillForm.newSkillDesc
          })
          .then((response) => {
            this.skillUpdateMoreThan50ErrorMessage = response.data
            this.ErrorskillUpdate50Visible = true
          })
      } else {
        await axios
          .post('http://localhost:8080/UpdateSkill', {
            skill_id: this.EditSkillForm.skillToEdit,
            skill_name: this.EditSkillForm.newSkillName,
            skill_des: this.EditSkillForm.newSkillDesc
          })
          .then((response) => {
            if (response.data.slice(0, 12) === 'Successfully') {
              console.log(response.data.slice(0, 12))
              this.skillUpdateSuccessMessage = response.data
              this.SuccessSkillUpdateDialogVisible = true
            } else if (response.data.slice(0, 12) === 'Skill name s') {
              this.skillUpdateMoreThan50ErrorMessage = response.data
              this.ErrorskillUpdate50Visible = true
            } else {
              console.log(response.data.slice(0, 12))
              this.skillUpdateErrorMessage = response.data
              // location.reload()
              this.ErrorSkillUpdateDialogVisible = true
            }
          })
      }
    },
    async deleteSkills() {
      await axios
        .post(
          'http://localhost:8080/DeleteSkill/' + this.EditSkillForm.skillToEdit
        )
        .then((response) => {
          this.skillDeleteSuccessMessage = response.data
          this.SuccessSkillDeleteDialogVisible = true
        })
    },
    // courseUpdateSuccess: '',
    //   courseUpdateSuccessVisible: false,
    //   courseUpdateFail: '',
    //   courseUpdateFailVisible
    // await axios
    //     .put('http://localhost:8080/editCourse', {
    //       id: this.EditCourseForm.courseToEditId,
    //       list: this.EditCourseForm.newCourseSkills
    async editCourses() {
      if (this.EditCourseForm.courseToEditId === '') {
        await axios
          .post('http://localhost:8080/editCourse', {
            id: '',
            list: this.EditCourseForm.newCourseSkills
          })
          .then((response) => {
            this.courseUpdateFail = response.data
            this.courseUpdateFailVisible = true
          })
      } else {
        await axios
          .post('http://localhost:8080/editCourse', {
            id: this.EditCourseForm.courseToEditId,
            list: this.EditCourseForm.newCourseSkills
          })
          .then((response) => {
            if (response.data.slice(0, 3) === 'No') {
              this.courseUpdateSuccess = response.data
              this.courseUpdateSuccessVisible = true
              // 새로운것
            } else {
              console.log(response.data.slice(0, 12))
              this.courseUpdateSuccess = response.data
              this.courseUpdateSuccessVisible = true
            }
          })
      }
    },
    reloadPage() {
      location.reload()
    }
  }
}
</script>

<style>
#filter-by {
  background-color: #546fff;
  color: white;
  padding: 10px;
}

.white-text {
  color: white !important;
  font-size: 1em;
  margin: 10px;
}

label.el-checkbox::after {
  content: '\a';
  white-space: pre;
  color: white !important;
  font-size: 1em;
  margin: 10px;
}

label.el-radio::after {
  content: '\a';
  white-space: pre;
  color: white !important;
  font-size: 1em;
  margin: 10px;
}

label.el-checkbox.black-text {
  color: black !important;
  font-size: 1em;
  margin-right: 100px;
}

.margin-box {
  margin: 20px;
}

i.el-icon-error {
  color: red !important;
}

.demo-input-label {
  display: inline-block;
  width: 130px;
}

.input-form {
  margin: auto;
  width: 50%;
  padding: 10px;
}

.course-card {
  margin: 20px !important;
}

.course-status {
  float: right !important;
}

div.scroll-bar {
  height: 800px !important;
  overflow: scroll !important;
}

div.filter-role {
  height: 160px;
  overflow: scroll !important;
  color: white !important;
}

div.filter-skill {
  height: 160px;
  overflow: scroll !important;
}

.add-button {
  font-size: 60px !important;
  color: #546fff !important;
}

.edit-button {
  font-size: 10px !important;
}

.el-card {
  height: 400px !important;
}
</style>
