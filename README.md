# README

Course Tutor app is a basic Rails API application that supports below actions - 

Creating a course with tutors-
  
API Endpoint - /courses
method       - POST
Headers      - {"accept": "application/json"}
Body         - {
                "name": "Course Name",
                "description": "course description",
                "duration": "2 days",
                "tutors_attributes": [
                  {
                        "name": "Tutor 1 name",
                        "email": "tutor email"
                  },
                  {
                        "name": "Tutor 2 name",
                        "email": "tutor email"
                  }
                ]
            }

The response looks like this - 

{
    "id": 11,
    "name": "Course Name",
    "description": "descrioption",
    "duration": "2 days",
    "tutors": [
        {
            "id": 8,
            "name": "Tutor 1 name",
            "email": "tutor email"
        },
        {
            "id": 9,
            "name": "Tutor 2 name",
            "email": "tutor email"
        }
    ]
}

Other supported actions include - 
1. list of courses with tutors - /courses.json
2. delete a course
3. update a course
4. show a course - /courses/:id.json
5. list of tutors with courses assigned - /tutors.json
6. show a tutor - /tutors/:id.json
7. delete a tutor
8. update a tutor

