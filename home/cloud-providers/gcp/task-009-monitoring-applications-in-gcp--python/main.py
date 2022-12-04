from flask import Flask, render_template, request
import googlecloudprofiler


app = Flask(__name__)
@app.route("/")
def main():
    model = {"title": "Hello DevOps Fans."}
    return render_template('index.html', model=model)

#  This code simply turns Profiler on. Once on, Profiler starts reporting application metrics to Google Cloud
try:
    googlecloudprofiler.start(verbose=3)
except (ValueError, NotImplementedError) as exc:
    print(exc)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True, threaded=True)

