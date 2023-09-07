import threading
from flask import Flask, jsonify
import random
import time

app = Flask(__name__)

# Initial random values
value_range = [250, 250, 250, 100]
values = [round(random.uniform(0, value_range[i]), 2) for i in range(4)]


def update_values():
    while True:
        time.sleep(3)  # Wait for 3 seconds
        new_values = [round(random.uniform(0, value_range[i]), 2)
                      for i in range(4)]
        values[:] = new_values  # Update the values list


@app.route('/get_values', methods=['GET'])
def get_values():
    return jsonify({'values': values})


if __name__ == '__main__':
    update_values_thread = threading.Thread(target=update_values)
    update_values_thread.daemon = True
    update_values_thread.start()
    app.run(debug=True, port=4000)
