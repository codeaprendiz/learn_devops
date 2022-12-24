import time
import random
import json
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/")
def home():
    model = {"title": "Hello DevOps Fans."}
    return render_template('index.html', model=model)

#  when you want to have 10 seconds delay in response
@app.route("/sleepy200")
def sleepy200():
    model = {"title": "Hello DevOps Fans. I just woke up from sleep"}
    time.sleep(10)
    return render_template('index.html', model=model)


# The route should give random 500 error
@app.route("/random500error")
def random500():
    num = random.randrange(20)
    if num == 0:
        return json.dumps({"error": 'Error thrown randomly'}), 500
    else:
        model = {"title": "Still 200 OK, try again :) ."}
        return render_template('index.html', model=model)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True, threaded=True)