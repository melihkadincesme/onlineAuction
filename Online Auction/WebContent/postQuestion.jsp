<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Post a Question</title>
</head>
<style>
	body{
		background-color:#FAEAC3;
		padding: 100px;
	}
	.form-container{
		border: 3px solid gray;
		padding: 20px;
	}
	.input-area{
		padding: 20px;
	}
	.input-area textarea{
		resize: none;
		width: 100%;
		height: 100px;
	}	
</style>
<body>

<a href = 'questions.jsp'>Go back</a>
<br>
<br>

    <div class="form-container">
        <form action="submitQuestion.jsp">
              <div class="input-area">
              	  <label for="name">Title:</label>
                  <input type="text" placeholder="Title" name="title" required>
               </div>
                <div class="input-area">
                    <label for="description">Description:</label>
                    <textarea name="description" placeholder="Type your question here" name="description" required></textarea>
                 </div>
         <button type="submit" name="action">Submit</button>
         </form>
    </div>

</body>
</html>