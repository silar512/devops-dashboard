from flask import Flask, jsonify
import psutil

app = Flask(__name__)

@app.route("/metrics")
def metrics():
    cpu = psutil.cpu_percent()
    memory = psutil.virtual_memory().percent
    disk = psutil.disk_usage('/').percent

    return jsonify({
        "cpu": cpu,
        "memory": memory,
        "disk": disk
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
