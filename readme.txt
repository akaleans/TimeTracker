Time Tracker Application Documentation

Section 1: Functionalities
	
	This application is intended to be used as a personal Time Tracker where users can submit current projects
	or tasks into a list that contains a name, description and number of hours worked for each project. Users
	can then select a project or task that they wish to clock in to work on. At the clock in view, users can
	see the current date and time and clock in, while clocked in users can only clock out and when the user
	clocks out they will be taken back to the project list page with the hours of the worked on project being
	updated.
	
	1.	User can create new projects and add them to the project list view
		a.	Project name
		b.	Project description
		c.	Number of hours worked already, if any
	2.	User can delete projects from the project list if they are done with them
	3.	User can select a project to work on
		a.	User taken to the clock in view with current time and date
		b.	User can clock in to the project
		c.	When user is done, user clocks out and the hours on the project are updated
		d.	User taken back to project list view
	4.	Search bar is currently not functional but will be updated at a later date

Secton 2: Architecture and Design
	
	Technologies
	1.	Swift SQLite for the project database
	2.	SwiftUI was used for the entire project
	3.	Project list is created using SwiftUI Scrollview
	4.	Bindings are used to pass around the project list from view to view

Section 3: Github
	
	https://github.com/akaleans/TimeTracker

Section 4: Test Results

	Each scenario tested was successful below.

	1.	With an empty project list
		a.	Click '+' to add a new project
		b.	Name project 'Project 1'
		c.	Project description 'Our first Project'
		d.	Hours worked '3.2'
		e.	Submit
	2.	With our new project added and at the project list view
		a.	Select 'Project 1' by clicking the right arrow
		b.	Clock in
		c.	Clock out after 10 minutes
	3.	At the project list view
		a.	Note that hours updated to 3.37
		b.	Delete project
	Test Complete

	1.	With an empty project list
		a.	Click '+' to add a new project
		b.	Name project 'Project 1'
		c.	Project description 'Our first Project'
		d.	Hours worked '3.2'
		e.	Submit
	2.	With our new project added and at the project list view
		a.	Select 'Project 1' by clicking the right arrow
		b.	Clock in
		c.	Clock out after 10 minutes
	3.	At the project list view
		a.	Note that hours updated to 3.37
		b.	Click '+' to add a new project
		c.	Name project 'Project 2'
		d.	Project description 'Our second Project'
		e.	Hours worked '1.0'
		d.	Submit
	4.	With our new project added and at the project list view
		a.	Note that both projects are in the list now
		b.	Select 'Project 2' by clicking the right arrow
		c.	Clock in
		d.	Clock out after 60 minutes
	5.	At the project list view
		a.	Note that hours updated to 2.0
		b.	Close Application
	6.	Open Application
		a.	Note that both projects persisted and have correct information
		b.	Close Application

	Both tests were successful.

Section 5: Future Work
	
	There are currently two features in the pipeline for this Time Tracker app
	
	1.	Make search bar functional
	2.	Add a 'notes' view that the user will be taken to after clocking out where they can include what was
		completed and what the next step for the project or task are
	
