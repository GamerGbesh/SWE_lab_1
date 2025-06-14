from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_migrate import Migrate  
import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from models import Users, Courses, Lecturers, Studentdeets

# basedir = os.path.abspath(os.path.dirname(__file__))
# instance_path = os.path.join(basedir, "instance")
# os.makedirs(instance_path, exist_ok=True)

class Config:
    SECRET_KEY = "you-will-never-guess"
    # SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
    #     'sqlite:///' + os.path.join(instance_path, 'app.db')
    # SQLALCHEMY_TRACK_MODIFICATIONS = False 

app = Flask(__name__)
app.config.from_object(Config)
CORS(app)
Migrate(app)

DATABASE_URL = "postgresql://postgres:gbeshko1@localhost:5432/School"
engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)


@app.route("/hello", methods=["POST"])
def say_hello():
    print(request.json)
    return jsonify({"hello": "world"}), 200


@app.route("/signup", methods=["POST"])
def create_user():
    username = request.json.get("username") 
    email =  request.json.get("email") 
    password = request.json.get("password") 
    confirm = request.json.get("password2") 
    session = Session()

    if not all((username, email, password, confirm)):
        return jsonify({"status": "error", "message": "Fields are missing"}), 400
    
    if password != confirm:
        return jsonify({"status": "error", "message": "Passwords do not match"}), 400
    
    if session.query(Users).filter_by(username=username).first():
        return jsonify({
            "status": "error",
            "message": "A user with that id already exists"
        }), 400
    
    if session.query(Users).filter_by(email=email).first():
        return jsonify({
            "status": "error",
            "message": "A user with that email already exists"
            }), 400


    user = Users(email=email, username=username) 
    try:
        user.set_password(password)
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 400
    
    session.add(user)
    session.commit()
    session.close()
    return jsonify({"status": "success", "message": "User created successfully"}), 201


@app.route("/login", methods=["POST"])
def login_user():
    username = request.json.get("username") 
    password = request.json.get("password") 
    session = Session()

    if not username or not password:
        return jsonify({
            "status": "error",
            "message": "Missing username or password"
        }), 400
    try:
        
        user = session.query(Users).filter_by(username=username).first()
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 404

    if not user:
        return jsonify({"status": "error", "message": "User does not exists"}), 404
    
    if not user.check_password(password):
        return jsonify({"status": "error", "message": "Password is wrong"}), 400
    
    session.close()
    
    return jsonify({"status": "success", "message": "User logged in successfully."}), 200
        

@app.route("/dash", methods=["GET"])
def showAll():
    session = Session()
    courses = session.query(Courses).all()
    lecturers = session.query(Lecturers).all()
    students = session.query(Studentdeets).all()
    courses_serial = [{"Course":x.course_name, "Description": x.course_description}  for x in courses]
    lecturers_serial = [{"Name": x.lecturer_first_name + " " + x.lecturer_last_name, "Phone": x.phone} for x in lecturers]
    students_serial = [{"Name": x.first_name + " " + x.last_name, "Phone": x.phone} for x in students]
    session.close()

    return jsonify({"courses": courses_serial, "lecturers":lecturers_serial, "students": students_serial})

# with app.app_context():
#     db.create_all()


if __name__ == "__main__":
    app.run()
    