"""Listener that report an issue when execution if a test fails."""
import requests 

ROBOT_LISTENER_API_VERSION = 3

def end_test(data, result):
    if not result.passed:
        response = requests.post("https://git.toptal.com/api/v4/projects/17154/issues?title="+result.name+",description="+result.message,
         headers={
           "PRIVATE-TOKEN": "sbem_9ogHeoxovFgX6j8"
         }
        )
        print('Created an issue "%s" ' % (response.text))        