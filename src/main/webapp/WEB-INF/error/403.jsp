<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied - Hamro Mart</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #f4fff4, #ffffff);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-card {
            max-width: 520px;
            width: 100%;
            background: #ffffff;
            border-radius: 18px;
            padding: 42px 34px;
            text-align: center;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
            border-top: 7px solid #28a745;
        }

        .icon {
            width: 86px;
            height: 86px;
            border-radius: 50%;
            background: #ffe9e9;
            color: #dc3545;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 42px;
            font-weight: bold;
            margin: 0 auto 18px;
        }

        .error-code {
            font-size: 76px;
            font-weight: 800;
            color: #dc3545;
            line-height: 1;
            margin-bottom: 10px;
        }

        h1 {
            margin: 0 0 12px;
            color: #222222;
            font-size: 30px;
        }

        p {
            margin: 0 auto 28px;
            color: #666666;
            font-size: 16px;
            line-height: 1.6;
            max-width: 430px;
        }

        .btn-group {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.2s ease;
        }

        .btn-primary {
            background: #28a745;
            color: white;
        }

        .btn-primary:hover {
            background: #218838;
        }

        .btn-secondary {
            background: #f1f1f1;
            color: #333333;
        }

        .btn-secondary:hover {
            background: #e1e1e1;
        }
    </style>
</head>
<body>

<div class="error-card">
    <div class="icon">!</div>
    <div class="error-code">403</div>
    <h1>Access Denied</h1>
    <p>
        You do not have permission to access this admin page.
        Only admin users are allowed to use admin features.
    </p>

    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Go to Login</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Back to Home</a>
    </div>
</div>

</body>
</html>
