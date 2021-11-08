
import gunicorn
import multiprocessing
import os

os.environ["SERVER_SOFTWARE"] = "domain_stats"
bind = "0.0.0.0:5730"
workers = 257
threads = 384
gunicorn.SERVER_SOFTWARE = 'domain_stats'
    
