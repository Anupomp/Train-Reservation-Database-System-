<!DOCTYPE html>
<html>
<head><title>Register</title></head>
<body>
    <h2>Register</h2>
    <form action="doRegister.jsp" method="post">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="hidden" name="role" value="customer">
        <input type="submit" value="Register">
    </form>
    <a href="login.jsp">Already have an account? Login</a>
</body>
</html>
