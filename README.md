# domain_stats2 Docker Image

This is an automatic build repository for the Docker image hasecuritysolutions/domain_stats2. If you have Docker installed you can deploy Mark Baggett's domain_stats2 service using the commands below.

```bash
docker pull hasecuritysolutions/domain_stats2
docker run -it -p 8000:8000 hasecuritysolutions/domain_stats2
```

For production use it is highly recommended that you create a persistent volume or bind mount for /opt/domain_stats2/data. This is were the domain_stats2 cache and database is stored. Example:

```bash
cd /opt
git clone https://github.com/MarkBaggett/domain_stats2.git
docker pull hasecuritysolutions/domain_stats2
docker run -it --name domain_stats2 -v /opt/domain_stats2/data:/opt/domain_stats2/data -p 8000:8000 hasecuritysolutions/domain_stats2
```
