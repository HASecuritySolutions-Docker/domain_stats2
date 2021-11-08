
import gunicorn
import multiprocessing
import os

os.environ["SERVER_SOFTWARE"] = "domain_stats"
bind = "0.0.0.0:5730"
workers = 64
threads = 128
gunicorn.SERVER_SOFTWARE = 'domain_stats'
    
