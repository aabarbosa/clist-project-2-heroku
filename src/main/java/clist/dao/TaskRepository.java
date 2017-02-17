package clist.dao;

import org.springframework.data.repository.CrudRepository;

import clist.model.Task;

public interface TaskRepository extends CrudRepository<Task, Integer>{

}
