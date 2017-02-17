<!DOCTYPE HTML>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Pragma" content="no-cache"> 
    <meta http-equiv="Cache-Control" content="no-cache"> 
    <meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
    
    <title>CList Project | Home</title>
    
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
     <link href="static/css/style.css" rel="stylesheet">
     
    
    <!--[if lt IE 9]>
		<script src="static/js/html5shiv.min.js"></script>
		<script src="static/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>

	<div role="navigation">
		<div class="navbar navbar-inverse">
			<a href="/" class="navbar-brand">HOME</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="new-category">New Category</a></li>
					<li><a href="new-task">New Task</a></li>
					<li><a href="all-tasks">All Tasks</a></li>
					<li><a href="contact">Contact</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<c:choose>
		<c:when test="${mode == 'MODE_HOME'}">
			<div class="container" id="homeDiv">
				<div class="jumbotron text-center">
					<h1>Welcome to this Project</h1>
				</div>
			</div>
		</c:when>
		
		<c:when test="${mode == 'MODE_GATEGORY'}">
			<div class="container text-center">
				<h3>CREATE A NEW CATEGORY</h3>
				<hr>
				<form class="form-horizontal" action="save-category">
					<div class="form-group">
						<label class="control-label col-md-3">Category Name</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="categoryName" value="${categoryName}"/>
						</div>				
					</div>
					
					<div class="form-group">
						<input type="submit" class="btn btn-primary" value="Save"/>
					</div>
				</form>
			</div>
		</c:when>
		
		<c:when test="${mode == 'MODE_TASKS'}">
			<div class="container text-center" id="tasksDiv">
				<h3>Table Of Tasks</h3>
				<hr>
				<div class="sortable table-responsive">
					<div class="form-group">
					<div>
						<label class="control-label col-md-3 text-right">Category Filter:</label>							
							<select class="col-md-3 text-left" style="width:190px" id="myInput" onchange="myFunction(3)">
								<option value="">All Categories</option>
								<c:forEach var="id" items="${categoryList}">
								<option value="${id}">${id}</option>
								</c:forEach>
							</select>
					</div>
					</div>
					<div class="form-group">
					<div>
						<label class="control-label col-md-3">Priority Filter:</label>							
							<select class="form-control" style="width:140px" name="text2" id="myInput2" onchange="myFunction(5)">
								<option value="">All Priorities</option>
								<option value="1-HIGH">High</option>
								<option value="2-MED">Medium</option>
								<option value="3-LOW">Low</option>
							</select>
					</div>
							
					</div>
					<table id="myTable" class="sortable table table-striped table-bordered text-left">
						<thead>
							<tr class="header">
								<th>Id</th>
								<th>Name</th>
								<th>Description</th>
								<th>Category</th>
								<th>Date Created</th>
								<th>Priority</th>
								<th>Finished</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="task" items="${tasks}">
								<tr>
									<td>${task.id}</td>
									<td>${task.name}</td>
									<td>${task.description}</td>
									<td>${task.categoryName}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${task.dateCreated}"/></td>
									<td>${task.priority}</td>
									<td>${task.finished}</td>
									<td><a href="update-task?id=${task.id}"><span class="glyphicon glyphicon-pencil"></span></a></td>
									<td><a href="delete-task?id=${task.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<form class="text-right" action="delete-all-tasks" method="get">
					 <input class="btn-primary" type="submit" value="Reset" 
						 onclick="return confirm('Do you want to delete all tasks?')"
					 />
				</form>
				
			</div>
			<hr>
				<center>${statistics}</center>
			<hr>
		</c:when>
		<c:when test="${mode == 'MODE_NEW' || mode == 'MODE_UPDATE'}">
			<div class="container text-center">
				<h3>Manage Task</h3>
				<hr>
				<form class="form-horizontal" method="POST" action="save-task">
					<input type="hidden" name="id" value="${task.id}"/>
					<div class="form-group">
						<label class="control-label col-md-3">Name</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name" value="${task.name}"/>
						</div>				
					</div>
										
					<div class="form-group">
						<label class="control-label col-md-3">Description</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="description" value="${task.description}"/>
						</div>				
					</div>
					
			   		<div class="form-group">
						<label class="control-label col-md-3">Priority</label>
						<div class="col-md-7">
							<input type="radio" class="col-sm-1" name="priority" value="1-HIGH"/>
							<div class="col-sm-1">High</div>
							<input type="radio" class="col-sm-1" name="priority" value="2-MED" />
							<div class="col-sm-1">Medium</div>
							<input type="radio" class="col-sm-2" name="priority" value="3-LOW" checked/>
							<div class="col-sm-1">Low</div>
						</div>				
					</div>
					
					<div class="form-group">
					<div>
						<label class="control-label col-md-3">Category</label>							
							<select class="form-control" style="width:190px" name="categoryName">
								<c:forEach var="id" items="${categoryList}">
									<option value="${id}">${id}</option>
								</c:forEach>
							</select>
							</div>		
					</div>
					
					<div class="form-group">
						<label class="control-label col-md-3">Finished</label>
						<div class="col-md-7">
							<input type="radio" class="col-sm-1" name="finished" value="true"/>
							<div class="col-sm-1">Yes</div>
							<input type="radio" class="col-sm-1" name="finished" value="false" checked/>
							<div class="col-sm-1">No</div>
						</div>				
					</div>
										
					<div class="form-group">
						<input type="submit" class="btn btn-primary" value="Save"/>
					</div>
				</form>
				<hr>
			</div>
		</c:when>
		<c:when test="${mode == 'MODE_CONTACT'}">
			<div class="container" id="contactDiv">
				<div class="jumbotron text-center">
					<h3><strong>Contact Information</strong></h3>
					<div>
						<address>
							<strong>Alekssandro Assis Barbosa</strong>
							<br>
							<a href="mailto:alekssandro.barbosa@ccc.ufcg.edu.br">alekssandro.barbosa@ccc.ufcg.edu.br</a>
							<br>
							<cite>Sistemas de Informação 1 - 2016.2 - Lab 03 on <a href="https://github.com/aabarbosa/clist-project-2">GitHub.</a></cite>
						 </address>
					</div>
				</div>
			</div>
		</c:when>	
	</c:choose>
	
	<script src="static/js/jquery-1.11.1.min.js"></script>    
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/sorttable.js"></script>
</body>
</html>