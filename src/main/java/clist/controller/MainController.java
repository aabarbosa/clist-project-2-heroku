package clist.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import clist.model.Task;
import clist.service.TaskService;

@Controller
public class MainController {

	@Autowired
	private TaskService taskService;

	@GetMapping("/")
	public String home(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_HOME");
		return "index";
	}

	@GetMapping("/contact")
	public String contact(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_CONTACT");
		return "index";
	}

	@GetMapping("/all-tasks")
	public String allTasks(HttpServletRequest request) {
		request.setAttribute("tasks", taskService.findAll());
		request.setAttribute("mode", "MODE_TASKS");
		request.setAttribute("statistics", taskService.statistics());
		request.setAttribute("categoryList", taskService.getCategories());
		return "index";
	}

	@GetMapping("/new-category")
	public String newCategory(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_GATEGORY");
		return "index";
	}

	@GetMapping("/save-category")
	public RedirectView saveCategory(String categoryName, HttpServletRequest request) {
		request.setAttribute("mode", "MODE_GATEGORY");
		taskService.saveNewCategory(categoryName);
		return new RedirectView("all-tasks");
	}

	@PostMapping("/save-task")
	public RedirectView saveTask(@ModelAttribute Task task, BindingResult bindingResult, HttpServletRequest request) {
		task.setDateCreated(new Date());
		taskService.save(task);
		request.setAttribute("tasks", taskService.findAll());
		request.setAttribute("mode", "MODE_TASKS");
		return new RedirectView("all-tasks");
	}
	
	@GetMapping("/new-task")
	public String newTask(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_NEW");
		request.setAttribute("categoryList", taskService.getCategories());
		return "index";
	}

	@GetMapping("/update-task")
	public String updateTask(@RequestParam int id, HttpServletRequest request) {
		Task task = taskService.findTask(id);
		request.setAttribute("task", task);
		request.setAttribute("mode", "MODE_UPDATE");
		request.setAttribute("categoryList", taskService.getCategories());
		return "index";
	}

	@GetMapping("/delete-task")
	public RedirectView deleteTask(@RequestParam int id, HttpServletRequest request) {
		taskService.delete(id);
		request.setAttribute("tasks", taskService.findAll());
		request.setAttribute("mode", "MODE_TASKS");
		return new RedirectView("all-tasks");
	}
	
	
	@GetMapping("/delete-all-tasks")
	public RedirectView deleteAllTasks(HttpServletRequest request){
		taskService.deleteAll();
		return new RedirectView("all-tasks");
	}
}
