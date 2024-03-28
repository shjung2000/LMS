import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'

import HrBrowse from '../components/hr/HrBrowse.vue'
import ManagerBrowse from '../components/manager/ManagerBrowse.vue'
import StaffLeanringJourney from '../components/staff/StaffLearningJourney.vue'
import StaffBrowse from '../components/staff/StaffBrowse.vue'

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: '/hr-browse',
    name: 'HrBrowse',
    component: HrBrowse
  },
  {
    path: '/manager-browse',
    name: 'ManagerBrowse',
    component: ManagerBrowse
  },
  {
    path: '/',
    name: 'StaffBrowse',
    component: StaffBrowse
  },
  {
    path: '/staff-learning-journey',
    name: 'StaffLearningJourney',
    component: StaffLeanringJourney
  }
  // {
  //   path: '/profile',
  //   name: 'Profile',
  //   component: () =>
  //     import(/* webpackChunkName: "profile" */ '../views/Profile.vue')
  // }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})
export default router
