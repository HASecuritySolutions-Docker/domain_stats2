
import gunicorn
import multiprocessing
import os

os.environ["SERVER_SOFTWARE"] = "domain_stats"
bind = "127.0.0.1:5730"
workers = 257
threads = 384
gunicorn.SERVER_SOFTWARE = 'domain_stats'
    