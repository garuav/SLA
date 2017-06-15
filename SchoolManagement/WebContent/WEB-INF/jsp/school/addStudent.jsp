<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Student</title>
<script src="<core:url value="/resources/js/jquery-3.1.1.min.js"/>"></script>
<script src="<core:url value="/resources/pagination/pagination.js"/>"></script>

<link rel="stylesheet"
	href="<core:url value="/resources/css/bootstrap.min.css"/>">

	
<!-- 	Pagination For approved Students-->
<script>
$(function () {
	
	load = function() {
		window.tp = new Pagination('#tablePaging1', {
			//itemsCount: 2,
			
			onPageSizeChange: function (ps) {
				console.log('changed to ' + ps);
			},
			onPageChange: function (paging) {
				//custom paging logic here
				console.log(paging);
				var start = paging.pageSize * (paging.currentPage - 1),
					end = start + paging.pageSize,
					$rows = $('#table1').find('.approvedData');

				$rows.hide();

				for (var i = start; i < end; i++) {
					$rows.eq(i).show();
				}
			}
		});
	}

load();
});

</script>

<!-- pagination For pending Students -->
<script>
$(function () {
	
	load = function() {
		window.tp = new Pagination('#tablePaging2', {
			//itemsCount: 2,
			
			onPageSizeChange: function (ps) {
				console.log('changed to ' + ps);
			},
			onPageChange: function (paging) {
				//custom paging logic here
				console.log(paging);
				var start = paging.pageSize * (paging.currentPage - 1),
					end = start + paging.pageSize,
					$rows = $('#table2').find('.pendingData');

				$rows.hide();

				for (var i = start; i < end; i++) {
					$rows.eq(i).show();
				}
			}
		});
	}

load();
});

</script>
<script>

	//function to show Add Student Form 
	$(document).ready(function(){
		$("#showAddStud").click(function(){
			$("#studentInput").fadeIn(1000);
			$("#studentDetailsApproved").hide();
			$("#studentDetailsPending").hide();
			$("#approvedStudent").attr("disabled",'disabled');
			$("#pendingStudent").attr("disabled",'disabled');
			$("#filterAlert").hide();

		});
	});
	
	//Function to Close Add Student Form 
	$(document).ready(function(){
		$("#close").click(function(){
			$("#studentInput").hide();
			$("#studentDetailsApproved").fadeIn(800);
			$("#approvedStudent").attr("disabled",'disabled');
			$("#pendingStudent").removeAttr('disabled');
		$("#filterAlert").fadeIn(700);

		});
	});
	//function to Show Pending Student Details 
	$(document).ready(function(){
		$("#pendingStudent").click(function(){
			$("#studentDetailsApproved").hide();
			$("#studentDetailsPending").fadeIn(800);
			$("#approvedStudent").removeAttr('disabled');
			$("#pendingStudent").attr("disabled",'disabled');
		});
	});
	
	//function to Show Approved Student Details 
	$(document).ready(function(){
		$("#approvedStudent").click(function(){
			$("#studentDetailsPending").hide();
			$("#studentDetailsApproved").fadeIn(800);
			$("#pendingStudent").removeAttr('disabled');
			$("#approvedStudent").attr("disabled",'disabled');
		});
	});
	
	//function to get division from specific School's Classes

	function getDivision() {

		$.ajax({
			url : 'getSchoolDivisionSch?schoolId',
			success : function(data) {
				$('#division').find('option').remove();

				showDivision(data);
			},
			error : function(data, status, errorThrown) {
				alert("Error= " + errorThrown + " Status= " + status);

			}

		});
	}
	function showDivision(data) {

$("#stream1").show(800);
		for (i = 0; i < data.length; i++)
			$('#division').append(
					'<option value="' + data[i] + '">' + data[i] + '</option>');

	}
	// Filter Function for Selecting Student 
	
	$(document).ready(function(){
		$("#filterButton").click(function(){
			var classFltr=$("#classFilter").val();
			var divFltr=$("#divFilter").val();
			var rollFltr=$("#rollNoFilter").val();
		var mobileFltr=$("#mobileNoFilter").val();
			alert("class filter = "+classFltr+" divFilter= "+divFltr+" roll No Filter = "+rollFltr+" Mobile No Filter = "+mobileFltr);

		location="filterFunction?classFilter="+classFltr+"&divFilter="+divFltr+"&rollNoFilter="+rollFltr+"&mobileFilter="+mobileFltr;
		});
	});
</script>
<style>
#filters li{
display:inline;
}
</style>
</head>
<body>

	<div class="container-fluid">
		<div class="row">
      		 <jsp:include page="/WEB-INF/jsp/school/navlink.jsp"/>
			<div class="col-md-10 col-xs-12 col-sm-10 col-md-offset-2 col-sm-offset-2" style="padding-top:56px">
			<div class="alert alert-success " 
												role="alert">
							<button id="showAddStud" class="btn btn-info" >Add Student</button>					
							<button id="approvedStudent" class="btn " disabled>Approved Student</button>					
							<button id="pendingStudent" class="btn ">Pending Student</button>					
												
												</div>
												<div class="alert alert-info " id="filterAlert" role="alert">Filters
												
									<ul id="filters">										
										<li><select id="classFilter" class="input-sm">
												<option value="" label="Select Class " />
												<core:forEach items="${schoolClass}" var="classListFilter">
													<option  value="${classListFilter}">${classListFilter}</option>
												</core:forEach>
										</select></li>
										<li><select id="divFilter" class="input-sm">
												<option value="" label="Select Division " />
												<core:forEach items="${schoolDiv}" var="divListFilter">
													<option  value="${divListFilter}">${divListFilter}</option>
												</core:forEach>
										</select></li>
										<li>
										<input type="text" class="input-sm" placeholder="Roll No" id="rollNoFilter">
										</li>
										<li>
											<input type="text" class="input-sm" placeholder="Mobile No" id="mobileNoFilter">
										
										</li>
										<li><button id="filterButton" class="btn-default">Filter</button></li>
									</ul>
								</div>
												
							
								
							
<!-- 			Approved Student Details  -->


			<div class="panel panel-default" id="studentDetailsApproved">
					<div class="panel-body">
					
												
							<h3 align="center">Student List</h3>
						<div class="page-header ">
							
						</div>
						<div class="table-responsive">
							<table class="table performAction" id="table1">

									<tr>
										<th>Class</th>
										<th>Division</th>
										<th>Roll No</th>
										<th>Name</th>
										<th>Mobile No</th>
										<th>Action</th>
									</tr>
								<core:forEach items="${showApprovedStudent}" var="showStud">
									<tr class="approvedData">
										<td>${showStud.standard}</td>
										<td>${showStud.division}</td>
										<td>${showStud.rollNo}</td>
										<td>${showStud.stuFirstName}${showStud.stuMiddleName}${showStud.stuLastName}</td>
										<td>${showStud.mobileNo}</td>
										<td>
										
										<a href="editStuSch?rollNo=${showStud.rollNo}" class="btn btn-primary">
										Edit</a>
										<a href="moreDetailsStuSch?rollNo=${showStud.rollNo}&schId=${showStud.schoolId}" class="btn btn-primary" >More Details</a>
										
										</td>
									</tr>
								</core:forEach>
									
							</table>
							        <div class="paging-container" id="tablePaging1"> </div>
							
						</div>
					</div>
					
			</div>		
			
<!-- 			Pending Student Details -->

<div class="panel panel-default" id="studentDetailsPending" style="display:none;">
					<div class="panel-body">
					
								
							<h3 align="center">Student List</h3>
						<div class="page-header ">
							
						</div>
						<div class="table-responsive">
							<table class="table performAction" id="table2">

									<tr>
										<th>Class</th>
										<th>Division</th>
										<th>Roll No</th>
										<th>Name</th>
										<th>Mobile No</th>
										<th>Action</th>
									</tr>
								<core:forEach items="${showPendingStudent}" var="showStud">
									<tr class="pendingData">
										<td>${showStud.standard}</td>
										<td>${showStud.division}</td>
										<td>${showStud.rollNo}</td>
										<td>${showStud.stuFirstName}${showStud.stuMiddleName}${showStud.stuLastName}</td>
										<td>${showStud.mobileNo}</td>
										<td>
										
										<a href="editStuSch?rollNo=${showStud.rollNo}" class="btn btn-primary">
										Edit</a>
										<a href="moreDetailsStuSch?rollNo=${showStud.rollNo}&schId=${showStud.schoolId}" class="btn btn-primary">More Details</a>
										
										</td>
									</tr>
								</core:forEach>
									
							</table>
							 <div class="paging-container" id="tablePaging2"> </div>
							
						</div>
					</div>
					
			</div>	

<!-- Add Student Form -->
				<div class="panel panel-default" id="studentInput" style="display:none">
					<div class="panel-body">
						<div class="page-header ">
						<button  id="close" style="float:right" class="btn btn-warning">CLOSE</button>
						<div>
							<h3 align="center">Add Students</h3>	
						</div>	
						</div>
						<div class="table-responsive">

							<form:form action="addStudentSch" modelattribute="addStudent">
								<table class="table ">
<tr>
										<td colspan="2"><div class="alert alert-info"
												role="alert">Student New Admission Details</div></td>
									</tr>
									<tr>
										<th>School Name</th>
										<th>Class</th>
									</tr>
									<tr>
										<td><input type="text"  class="form-control"
											value="${schName}" disabled></td>
										<td><select name="standard" id="standard" 
											onchange="getDivision();" class="form-control">
												<option value="" label="Select Class " />
												<core:forEach items="${schoolClass}" var="classDeatils">
													<option value="${classDeatils}">${classDeatils}</option>
												</core:forEach>
										</select></td>

									</tr>


									<tr>
										<th>Division</th>

										<th id="stream" style="display: none">Stream</th>
									</tr>
									<tr>
										<td><select name="division" id="division" 
											class="form-control">
												<option value="" label="Select Division " />

										</select></td>
										<td id="stream1" style="display: none"><select 
											name="stream" class="form-control">
												<option value="" label="Select Stream " />
												<option value="science">Science</option>
												<option value="arts">Arts</option>
												<option value="commerce">Commerce</option>
										</select></td>
									</tr>

									<tr>
										<td colspan="2"><div class="alert alert-info"
												role="alert">Student Personal Details</div></td>
									</tr>
									<tr>
										<th>Roll No</th>
										<th>Unique Id(Aadhar No)</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" name="rollNo" ></td>
										<td><input type="text" class="form-control" name="uniqueId" ></td>

									</tr>
									<tr>
										<th>Student Name (First)</th>
										<th>(Middle)</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" 
											name="stuFirstName"></td>
										<td><input type="text" class="form-control" 
											name="stuMiddleName"></td>
									</tr>
									<tr>
										<th>(Last)</th>
										<th>Mother's Name</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" 
											name="stuLastName"></td>
										<td><input type="text" class="form-control" 
										name="motherName"></td>
									</tr>
									<tr>
										<th>Nationality</th>
										<th>Mother Tongue</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" 
											name="nationality"></td>
										<td><input type="text" class="form-control" 
											name="motherTongue"></td>
									</tr>
									<tr>
										<th>Religion</th>
										<th>Cast</th>
									</tr>
									<tr>
										<td><select name="religion" class="form-control" >
												<option value="" label="Select Religion " />
												<option value="hindu">HINDU</option>
												<option value="muslim">MUSLIM</option>
												<option value="sikh">SIKH</option>
												<option value="christian">CHRISTIAN</option>

										</select></td>
										<td><input type="text" class="form-control"  name="cast"></td>
									</tr>
									<tr>
										<th>Sub Cast</th>
										<th>Birth Place</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" name="subCast" ></td>
										<td><input type="text" class="form-control" name="birthPlace" ></td>
									</tr>
									<tr>
										<th>Taluka</th>
										<th>District</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" name="taluka" ></td>
										<td><input type="text" class="form-control" name="district" ></td>
									</tr>
									<tr>
										<th>State</th>
										<th>Country</th>
									</tr>
									<tr>
										<td><input type="text" class="form-control" name="state" ></td>
										<td><input type="text" class="form-control" name="country" ></td>
									</tr>
									<tr>
										<th>Date Of Birth</th>
										<th>Date Of Birth in Words</th>
									</tr>
									<tr>
										<td><input type="date" name="dob" onchange="wordsDob(this.value);" class="form-control" ></td>
										<td><input type="text" name="dobWords" class="form-control"></td>
									</tr>

									<tr>
										<th>Gender</th>
										<th>Language</th>
									</tr>
									<tr>
										<td><select name="gender" class="form-control" >
												<option value="" label="Select Gender " />
												<option value="male">MALE</option>
												<option value="female">FEMALE</option>

										</select></td>
										<td><select name="language" class="form-control" >
												<option value="" label="Select Language " />
												<option value="hindi">HINDI</option>
												<option value="english">ENGLISH</option>
												<option value="marathi">MARATHI</option>
										</select></td>

									</tr>
									<tr>
										<th>Mobile No</th>
										<th>Category</th>

									</tr>
									<tr>
										<td><input type="text" name="mobileNo" class="form-control" ></td>
<td colspan="2"><select name="category" class="form-control" >
												<option value="" label="Select Category " />
												<core:forEach items="${category}" var="categorySchool">
													<option value="${categorySchool}">${categorySchool}</option>
												</core:forEach>
										</select></td>
									</tr>
									<tr>
										<td colspan="2"><div class="alert alert-info"
												role="alert">Bank Details</div></td>
									</tr>
									<tr>
										<th>Bank Name</th>
										<th>Bank Account No</th>
										
									</tr>
									<tr>
										<td><input type="text" name="bankName" class="form-control" ></td>
										<td><input type="text" name="bankAccNo" class="form-control" ></td>

									</tr>
									<tr>
									<th colspan="2">IFSC Code / Branch Name</th>
									</tr>
									<tr>
									<td colspan="2"><input type="text" name="branchOrIfsc" class="form-control" ></td>
									</tr>
									<tr>
										<td colspan="2"><div class="alert alert-info"
												role="alert">Previous School Details</div></td>
									</tr>
									<tr>
										<th>School Name</th>
										<th>Class</th>
									</tr>
									<tr>
										<td><input type="text" name="previousSchName" 
											class="form-control"></td>
										<td><input type="text" name="previousSchClass" 
											class="form-control"></td>
									</tr>


									
								</table>
								<input type="submit" value="Add" class="btn btn-primary ">
								<input type="reset" value="Clear" class="btn btn-primary ">
							</form:form>
						</div>
						<h3 style="color: green">${resultSuccess}</h3>
						<h3 style="color: red">${resultFail}</h3>
					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- <script>
 //Date Of Birth to Words 
	function wordsDob(value)
	{		alert("value= "+value);

		var wDays = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', '	seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth', 'thirteenth', 'fourteenth', 'fifteenth', 'sixteenth', 'seventeenth', 'eighteenth', 'nineteenth', 'twentieth', 'twenty-one', 'twenty-two', 'twenty-three', 'twenty-four', 'twenty-five', 'twenty-six', 'twenty-seven', 'twenty-eight', 'twenty-nine', 'thirty', 'thirty-one'];
		var wMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		var wNumbers = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty', 'twentyone'];
		var wUnits=['ten','twenty','thirty','forty','fifty','sixty','seventy','eighty','ninty'];
		var dateSplit=value.split("-");
		var days=(dateSplit[2])-1;
		var month=(dateSplit[1])-1;
		var year=dateSplit[0].toString();
		
		var x = year.charAt(0);
		var xx = year.charAt(1);
		var xxx = year.charAt(2);
		var xxxx = year.charAt(3);
		var a = parseInt(x + xx) - 1;
		var b = parseInt(xxx) - 1;
		var c = parseInt(xxxx) - 1;
		alert("Split date : Day = "+wDays[days]+" Month = "+wMonths[month]+" Year = "+wNumbers[a]+wNumbers[b]+wNumbers[c]);
		}

	</script>  -->
</body>
</html>