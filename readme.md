# Blueprint for JAVA Spring Boot Application

Running SpringBoot app, including gradle and docker build, with your own naming and initial git commit. No need to code anything for that.

It also includes Swagger UI for testing and using the app (call http://locahost:8080 in your browser for that).

All is wrapped in docker, so that you don't need to install anything (except docker and git ;-) ).

**Clone and run script:**

```
    $> ./init_app.sh
```

What is this script doing?
1. Replaces all required strings in the files/folders with your name
2. Creates an initial git commit for your app
