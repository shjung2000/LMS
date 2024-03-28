package com.spm.g8t6;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spm.g8t6.Role.roleService;
import com.spm.g8t6.Skill.skillService;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.*;

import java.io.IOException;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.json.*;
import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.spm.g8t6.Role.role;
import com.spm.g8t6.Skill.skill;
import com.spm.g8t6.Learning_Journey.learning_journey;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.web.servlet.MockMvc;


import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.web.client.RestTemplate;

//import org.junit.Test;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@SpringBootTest (webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class G8t6ApplicationTests {

	@LocalServerPort
	private int port;

	private String baseUrl ="http://localhost";

	public static RestTemplate restTemplate;

//	@Autowired
//	private TestRestTemplate restTemplate;

	@Autowired
	testroleRepo testroleRepo;

	@Autowired
	testskillRepo testskillRepo;

	@Autowired
	testljRepo testljRepo;

	@Autowired
	ObjectMapper objectMapper;

	//@Autowired
	//MockMvc mockMvc;



	//before running any test case
	@BeforeAll
	public static void init(){
		restTemplate = new RestTemplate();
	}

	//before running each test case
	@BeforeEach
	public void setUp(){
		baseUrl = baseUrl.concat(":").concat(port+"");
	}

	//@BeforeClass
	//public static void runBeforeAllTestMethods() throws JSONException {

	@Test
	void runBeforeAllTestMethods() throws JSONException {
//		String createRoleUrl = "http://localhost:8080/CreateRole";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

	}

	// Working Template
 // [Working] US3-1 - Create A Role
	// https://www.baeldung.com/spring-resttemplate-post-json

//	@Test
//	void testAddRole()
//			throws IOException, JSONException {
//
//		String createRoleUrl = "http://localhost:8080/CreateRole";
//
//		restTemplate = new RestTemplate();
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.APPLICATION_JSON);
//
//		JSONObject roleJsonObject = new JSONObject();
//		roleJsonObject.put("role_name", "TestRole");
//		roleJsonObject.put("role_description", "TestRole" );
//		ObjectMapper objectMapper = new ObjectMapper();
//
//		HttpEntity<String> request =
//				new HttpEntity<String>(roleJsonObject.toString(), headers);
//
//		String roleResultAsJsonStr =
//				restTemplate.postForObject(createRoleUrl, request, String.class);
//		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);
//
//		// if data is in DB
//		//assertThat(roleResultAsJsonStr).isEqualTo("\"TestRole\" already exists");
//
//		// if data is not in DB
//		assertThat(roleResultAsJsonStr).isEqualTo("Successfully created \"TestRole\"");
//	}

	@Test
	void TC_US_3_1_1()
			throws IOException, JSONException {
		String createRoleUrl = "http://localhost:8080/CreateRole";
		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JSONObject roleJsonObject = new JSONObject();
		roleJsonObject.put("role_name", "Cybersecurity");
		roleJsonObject.put("role_description", "Must have knowledge of operating environments" );
		ObjectMapper objectMapper = new ObjectMapper();
		HttpEntity<String> request =
				new HttpEntity<String>(roleJsonObject.toString(), headers);
		String roleResultAsJsonStr =
				restTemplate.postForObject(createRoleUrl, request, String.class);
		// if data is not in DB
		assertThat(roleResultAsJsonStr).isEqualTo("Successfully created \"Cybersecurity\"");
	}

	@Test
	void TC_US_3_1_2()
			throws IOException, JSONException {
		String createRoleUrl = "http://localhost:8080/CreateRole";
		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JSONObject roleJsonObject = new JSONObject();
		roleJsonObject.put("role_name", "Full-stack Developer");
		roleJsonObject.put("role_description", "Full-stack Developer Description" );
		ObjectMapper objectMapper = new ObjectMapper();
		HttpEntity<String> request =
				new HttpEntity<String>(roleJsonObject.toString(), headers);
		String roleResultAsJsonStr =
				restTemplate.postForObject(createRoleUrl, request, String.class);
		// if data is not in DB
		assertThat(roleResultAsJsonStr).isEqualTo("\"Full-stack Developer\" already exists");
	}

	@Test
	void TC_US_3_1_3()
			throws IOException, JSONException {
		String createRoleUrl = "http://localhost:8080/CreateRole";
		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JSONObject roleJsonObject = new JSONObject();
		roleJsonObject.put("role_name", "Full-stack Developers");
		roleJsonObject.put("role_description", "Full-stack Developer Description" );
		ObjectMapper objectMapper = new ObjectMapper();
		HttpEntity<String> request =
				new HttpEntity<String>(roleJsonObject.toString(), headers);
		String roleResultAsJsonStr =
				restTemplate.postForObject(createRoleUrl, request, String.class);
		// if data is not in DB
		assertThat(roleResultAsJsonStr).isEqualTo("Role name should be less than or equals to 20 characters");
	}

	@Test
	void TC_US_3_1_4()
			throws IOException, JSONException {
		String createRoleUrl = "http://localhost:8080/CreateRole";
		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JSONObject roleJsonObject = new JSONObject();
		roleJsonObject.put("role_name", "Full-stack Developerss");
		roleJsonObject.put("role_description", "Full-stack Developer Description" );
		ObjectMapper objectMapper = new ObjectMapper();
		HttpEntity<String> request =
				new HttpEntity<String>(roleJsonObject.toString(), headers);
		String roleResultAsJsonStr =
				restTemplate.postForObject(createRoleUrl, request, String.class);
		// if data is not in DB
		assertThat(roleResultAsJsonStr).isEqualTo("Role name should be less than or equals to 20 characters");
	}
	@Test
	void TC_US_3_1_5()
			throws IOException, JSONException {
		String createRoleUrl = "http://localhost:8080/CreateRole";
		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JSONObject roleJsonObject = new JSONObject();
		roleJsonObject.put("role_name", "");
		roleJsonObject.put("role_description", "" );
		ObjectMapper objectMapper = new ObjectMapper();
		HttpEntity<String> request =
				new HttpEntity<String>(roleJsonObject.toString(), headers);
		String roleResultAsJsonStr =
				restTemplate.postForObject(createRoleUrl, request, String.class);
		// if data is not in DB
		assertThat(roleResultAsJsonStr).isEqualTo("Name field cannot be empty");
	}


//	[Working] US1-1 - Get all Roles
	@Test
	void GetAllRoleEndpoint_ShouldReturnRoleLists(){
		String baseUrl = "http://localhost:" + port + "/AllRole";
		ResponseEntity<role[]> response =  restTemplate.getForEntity(baseUrl, role[].class);
		//Assertion methods
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody().length).isGreaterThanOrEqualTo(2);
	}

//	[Working] US1-2 - Get one Role [Method 1]
	@Test
	void GetOneRoleEndpoint_ShouldReturnOneRole(){
		String baseUrl = "http://localhost:" + port + "/oneRole/" + "10502";
		ResponseEntity<role> response =  restTemplate.getForEntity(baseUrl, role.class);
		//Assertion methods
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		//print output
		//System.out.println(response.getBody());
		assertThat(response.getBody().getRole_id()).isEqualTo(10502);
		//assertThat(response.getBody().length).isGreaterThanOrEqualTo(1);
	}

	// [Working]  Get one Role [Method 2]
		@Test
		public void getOneRole() throws JSONException{
			//RequestBuilder request = new URL("http://localhost:8080/oneRole/10502").getContent();
			//MvcResult String result = mvc.perform(request).andReturn();
			ResponseEntity<role> response = restTemplate
					.getForEntity("http://localhost:8080/oneRole/10502", role.class);

			assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
			assertThat(response.getBody().getRole_name()).isEqualTo("Back-end Developer");

		}


//     template
	// [Working] US3-1 - Create A Role
	// https://www.baeldung.com/spring-resttemplate-post-json
//	@Test
//	void testAddSkill()
//			throws IOException, JSONException {
//
//		String createSkillUrl = "http://localhost:8080/CreateSkill";
//
//		restTemplate = new RestTemplate();
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.APPLICATION_JSON);
//
//		JSONObject skillJsonObject = new JSONObject();
//		skillJsonObject.put("skill_name", "skilltest");
//		skillJsonObject.put("skill_des", "skilltest" );
//		ObjectMapper objectMapper = new ObjectMapper();
//
//		HttpEntity<String> request =
//				new HttpEntity<String>(skillJsonObject.toString(), headers);
//
//		String roleResultAsJsonStr =
//				restTemplate.postForObject(createSkillUrl, request, String.class);
//		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);
//
//		// if data is not in DB
//		assertThat(roleResultAsJsonStr).isEqualTo("Successfully Created \"skilltest\"");
//	}

	@Test
	void TC_US_4_1_1_CreateSkill()
			throws IOException, JSONException {

		String createSkillUrl = "http://localhost:8080/CreateSkill";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject skillJsonObject = new JSONObject();
		skillJsonObject.put("skill_name", "Test Skill 1");
		skillJsonObject.put("skill_des", "Test Skill 1 Description" );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(skillJsonObject.toString(), headers);

		String skillResultAsJsonStr =
				restTemplate.postForObject(createSkillUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(skillResultAsJsonStr).isEqualTo("Successfully Created \"Test Skill 1\"");
	}

	@Test
	void TC_US_4_1_2_CreateSkill()
			throws IOException, JSONException {

		String createSkillUrl = "http://localhost:8080/CreateSkill";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject skillJsonObject = new JSONObject();
		skillJsonObject.put("skill_name", "Excel Basics 1");
		skillJsonObject.put("skill_des", "Excel Basics 1 Description" );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(skillJsonObject.toString(), headers);

		String skillResultAsJsonStr =
				restTemplate.postForObject(createSkillUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(skillResultAsJsonStr).isEqualTo("\"Excel Basics 1\" already exists!");
	}

	@Test
	void TC_US_4_1_3_CreateSkill()
			throws IOException, JSONException {

		String createSkillUrl = "http://localhost:8080/CreateSkill";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject skillJsonObject = new JSONObject();
		skillJsonObject.put("skill_name", "Managing Customer Relationships with Data Analytics");
		skillJsonObject.put("skill_des", "MCRA Description" );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(skillJsonObject.toString(), headers);

		String skillResultAsJsonStr =
				restTemplate.postForObject(createSkillUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(skillResultAsJsonStr).isEqualTo("Skill name should be less than or equals to 50 characters");
	}

	@Test
	void TC_US_4_1_4_CreateSkill()
			throws IOException, JSONException {

		String createSkillUrl = "http://localhost:8080/CreateSkill";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject skillJsonObject = new JSONObject();
		skillJsonObject.put("skill_name", "Managing Customer Relationships with Data Analytics1");
		skillJsonObject.put("skill_des", "MCRA1 Description" );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(skillJsonObject.toString(), headers);

		String skillResultAsJsonStr =
				restTemplate.postForObject(createSkillUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(skillResultAsJsonStr).isEqualTo("Skill name should be less than or equals to 50 characters");
	}

	@Test
	void TC_US_4_1_5_Create_Skill()
			throws IOException, JSONException {

		String createSkillUrl = "http://localhost:8080/CreateSkill";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject skillJsonObject = new JSONObject();
		skillJsonObject.put("skill_name", "");
		skillJsonObject.put("skill_des", "" );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(skillJsonObject.toString(), headers);

		String skillResultAsJsonStr =
				restTemplate.postForObject(createSkillUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(skillResultAsJsonStr).isEqualTo("Name field cannot be empty");
	}



	//	[Working]
	@Test
	void US_1_8_1_Get_All_Skill()
			throws IOException, JSONException{
		String baseUrl = "http://localhost:" + port + "/AllSkill";
		ResponseEntity<skill[]> response =  restTemplate.getForEntity(baseUrl, skill[].class);
		//Assertion methods
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody().length).isGreaterThanOrEqualTo(2);
	}

	@Test
	void TC_US_2_1_createLJ()
			throws IOException, JSONException {

		String createLJUrl = "http://localhost:8080/createLearningJourney";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject ljJsonObject = new JSONObject();
		ljJsonObject.put("staff_id", 130001);
		ljJsonObject.put("role_id", 10021);
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(ljJsonObject.toString(), headers);

		String ljResultAsJsonStr =
				restTemplate.postForObject(createLJUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(ljResultAsJsonStr).isEqualTo("Learning Journey with Role Name: Front-end Developer created successfully!");

		// if data in DB
		//assertThat(ljResultAsJsonStr).isEqualTo("The learning journey with the following Role Name: Front-end Developer has already been created!");

	}
//	@Test
//	void TC_US_2_2_Error()
//			throws IOException, JSONException {
//
//		String createLJUrl = "http://localhost:8080/addCourse";
//
//		restTemplate = new RestTemplate();
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.APPLICATION_JSON);
//
//		JSONObject ljJsonObject = new JSONObject();
//
//		ObjectMapper objectMapper = new ObjectMapper();
//
//		HttpEntity<String> request =
//				new HttpEntity<String>(ljJsonObject.toString(), headers);
//
//		String ljResultAsJsonStr =
//				restTemplate.postForObject(createLJUrl, request, String.class);
//
//		assertThat(ljResultAsJsonStr).isEqualTo("You need at least 1 course in your Learning Journey");
//
//	}



	@Test
	void SuccessAddingCourseToRole()throws IOException, JSONException {

		String AddCourseToRoleLJUrl = "http://localhost:8080/addCourse";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject ljJsonObject = new JSONObject();
		ljJsonObject.put("role_id", 10021);
		ljJsonObject.put("course_id", "COR001");
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(ljJsonObject.toString(), headers);

		String ljResultAsJsonStr =
				restTemplate.postForObject(AddCourseToRoleLJUrl, request, String.class);
		//JsonNode root = objectMapper.readTree(roleResultAsJsonStr);

		// if data is not in DB
		assertThat(ljResultAsJsonStr).isEqualTo("Successfully added \"Systems Thinking and Design\" to My Courses");

		// if data in DB
		//assertThat(ljResultAsJsonStr).isEqualTo("\"Systems Thinking and Design\" has already been added");

	}

	@Test
	void TC_US_2_2_2()throws IOException, JSONException {

		String startLJUrl = "http://localhost:8080/startLearningJourney/1";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject ljJsonObject = new JSONObject();
		ljJsonObject.put("role_id", 10021);
		ljJsonObject.put("course_id", "COR001");
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(ljJsonObject.toString(), headers);

		String ljResultAsJsonStr =
				restTemplate.postForObject(startLJUrl, request, String.class);

		assertThat(ljResultAsJsonStr).isEqualTo("Successfully started Learning Journey for \"Front-end Developer\"");

	}


	@Test
	void TC_US_2_4_DeleteLJ()throws IOException, JSONException {

		String deleteLJUrl = "http://localhost:8080/deleteLearningJourney/1";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject ljJsonObject = new JSONObject();
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(ljJsonObject.toString(), headers);

		String ljResultAsJsonStr =
				restTemplate.postForObject(deleteLJUrl, request, String.class);

		assertThat(ljResultAsJsonStr).isEqualTo("Successfully deleted learning journey for \"Front-end Developer\"");

	}

	// @Test
	// void Remove_a_Course_LJ()throws IOException, JSONException {

	// 	String RemoveCourseLJUrl = "http://localhost:8080/removeCourse";

	// 	restTemplate = new RestTemplate();
	// 	HttpHeaders headers = new HttpHeaders();
	// 	headers.setContentType(MediaType.APPLICATION_JSON);

	// 	JSONObject ljJsonObject = new JSONObject();
	// 	ljJsonObject.put("role_id", 10203);
	// 	ljJsonObject.put("course_id", "COR001");
	// 	ObjectMapper objectMapper = new ObjectMapper();

	// 	HttpEntity<String> request =
	// 			new HttpEntity<String>(ljJsonObject.toString(), headers);

	// 	String ljResultAsJsonStr =
	// 			restTemplate.postForObject(RemoveCourseLJUrl, request, String.class);

	// 	assertThat(ljResultAsJsonStr).isEqualTo("Successfully removed \"Systems Thinking and Design\" from my Courses");

	// }

	@Test
	void Delete_a_role_disable()throws IOException, JSONException {

		String DisableRoleJUrl = "http://localhost:8080/DeleteRole/10503";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject disableJsonObject = new JSONObject();
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(disableJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(DisableRoleJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("Successfully deactivated \"AnotherTest\"");

	}

	@Test
	void Delete_a_skill_disable()throws IOException, JSONException {

		String DisableSkillJUrl = "http://localhost:8080/DeleteSkill/13";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject disableJsonObject = new JSONObject();
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(disableJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(DisableSkillJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("Successfully deactivated \"Yet another Skill Test\"");

	}

	@Test
	void US_4_4_assign_skill_to_course()throws IOException, JSONException {

		String AssignSkillToCourseJUrl = "http://localhost:8080/editCourse";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		List<String> list = new ArrayList<String>();
		list.add("5");
		list.add("9");
		JSONArray array = new JSONArray();
		for(int i = 0; i < list.size(); i++) {
			array.put(list.get(i));
		}

		JSONObject editJsonObject = new JSONObject();
		editJsonObject.put("id", "COR001");
		editJsonObject.put("list", array );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(editJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(AssignSkillToCourseJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("Successfully Assigned \"Express JS, Bootstrap\" to \"Systems Thinking and Design\"");
	}


	@Test
	void US_4_4_deassign_skill_to_course()throws IOException, JSONException {

		String AssignSkillToCourseJUrl = "http://localhost:8080/editCourse";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		List<String> list = new ArrayList<String>();
		JSONArray array = new JSONArray();
		for(int i = 0; i < list.size(); i++) {
			array.put(list.get(i));
		}

		JSONObject editJsonObject = new JSONObject();
		editJsonObject.put("id", "COR001");
		editJsonObject.put("list", array );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(editJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(AssignSkillToCourseJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("No skills are assigned to Course: Systems Thinking and Design");
	}


	@Test
	void US_4_6_edit_role_add_skill()throws IOException, JSONException {

		String AssignSkillToCourseJUrl = "http://localhost:8080/editRole";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		List<String> list = new ArrayList<String>();
		list.add("5");
		list.add("9");
		JSONArray array = new JSONArray();
		for(int i = 0; i < list.size(); i++) {
			array.put(list.get(i));
		}

		JSONObject editJsonObject = new JSONObject();
		editJsonObject.put("id", 10022);
		editJsonObject.put("name", "");
		editJsonObject.put("des", "");
		editJsonObject.put("list", array );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(editJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(AssignSkillToCourseJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("Successfully Assigned \"Express JS, Bootstrap\" to \"TestRole\"");
	}

	@Test
	void US_4_6_edit_role_no_skill()throws IOException, JSONException {

		String AssignSkillToCourseJUrl = "http://localhost:8080/editRole";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		List<String> list = new ArrayList<String>();

		JSONArray array = new JSONArray();
		for(int i = 0; i < list.size(); i++) {
			array.put(list.get(i));
		}

		JSONObject editJsonObject = new JSONObject();
		editJsonObject.put("id", 10023);
		editJsonObject.put("name", "");
		editJsonObject.put("des", "");
		editJsonObject.put("list", array );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(editJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(AssignSkillToCourseJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("No skills are assigned to \"CEO\"");
	}

	@Test
	void editRole_name()throws IOException, JSONException {

		String AssignSkillToCourseJUrl = "http://localhost:8080/editRole";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		List<String> list = new ArrayList<String>();

		JSONArray array = new JSONArray();
		for(int i = 0; i < list.size(); i++) {
			array.put(list.get(i));
		}

		JSONObject editJsonObject = new JSONObject();
		editJsonObject.put("id", 10022);
		editJsonObject.put("name", "Yet Another Role");
		editJsonObject.put("des", "YAR testing Description");
		editJsonObject.put("list", array );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(editJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(AssignSkillToCourseJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("Updated \"Yet Another Role\" and No skills are assigned to  \"Yet Another Role\"");
	}

	@Test
	void editRole_all_attributes()throws IOException, JSONException {

		String AssignSkillToCourseJUrl = "http://localhost:8080/editRole";

		restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		List<String> list = new ArrayList<String>();
		list.add("5");
		list.add("9");
		JSONArray array = new JSONArray();
		for(int i = 0; i < list.size(); i++) {
			array.put(list.get(i));
		}

		JSONObject editJsonObject = new JSONObject();
		editJsonObject.put("id", 10022);
		editJsonObject.put("name", "Master Role");
		editJsonObject.put("des", "Master Role Description");
		editJsonObject.put("list", array );
		ObjectMapper objectMapper = new ObjectMapper();

		HttpEntity<String> request =
				new HttpEntity<String>(editJsonObject.toString(), headers);

		String disableResultAsJsonStr =
				restTemplate.postForObject(AssignSkillToCourseJUrl, request, String.class);
		assertThat(disableResultAsJsonStr).isEqualTo("Successfully Updated \"Master Role\" and successfully assigned \"Express JS, Bootstrap\" to \"Master Role\"");
	}



}

// Other method testing using MVC
//@WebMvcTest
//class TestingUsingMVC{
//	@LocalServerPort
//	private int port;
//
//	private String baseUrl ="http://localhost";
//
//	public static RestTemplate restTemplate;
//
////	@Autowired
////	private TestRestTemplate restTemplate;
//
//	@Autowired
//	testroleRepo testroleRepo;
//
//	@Autowired
//	testskillRepo testskillRepo;
//
//	@Autowired
//	testljRepo testljRepo;
//
//	@Autowired
//	ObjectMapper objectMapper;
//
//	@Autowired
//	private MockMvc mockMvc;
//
//	@MockBean
//	private com.spm.g8t6.Role.roleService roleService;
//	@MockBean
//	private com.spm.g8t6.Skill.skillService skillService;
//	@MockBean
//	private com.spm.g8t6.Learning_Journey.learning_journeyService learning_journeyService;
//	@MockBean
//	private com.spm.g8t6.Role_Has_Skill.role_has_skill_Service role_has_skill_Service;
//	@MockBean
//	private com.spm.g8t6.Course_Has_Skill.course_has_skill_Service course_has_skill_Service;
//	@MockBean
//	private com.spm.g8t6.Course.courseService courseService;
//	@MockBean
//	private com.spm.g8t6.Registration.registrationService registrationService;
//
//	@Test
//	void TestingDelete(){
//
////		String deleteLjUrl = "http://localhost:8080/deleteLearningJourney/13";
////
////		Mockito.when(studentService.deleteStudent(ArgumentMatchers.anyString())).thenReturn("Student is deleted");
////		MvcResult requestResult = mockMvc.perform(delete(URIConstant.DELETE_MAPPING).param("student-id", "1"));
//	}
//
//
//
//
//
//}



