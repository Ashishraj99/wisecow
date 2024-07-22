import requests

def check_application_health(url):
    
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return 'up'
        else:
            return 'down'
    except requests.RequestException:
        return 'down'

# Example usage
application_url = "http://google.com"
health_status = check_application_health(application_url)

# Print health status
print(f"The application is {health_status}")
