# Colima - Running x86_64 Containers on Apple M1

[index](index.md)

*Abstract* : some software still does not run on arm architecture. (for instance mac os).
			One notable example is oracle (see for instance the oracle docker image 
			[FAQ](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/FAQ.md).
			[Colima](https://github.com/abiosoft/colima/blob/main/README.md) offers a practical way to to
			run x64 containers on arm systems.
			(As Colima readmes itself states, Colima stands for 'Containers on Linux on Mac.')
			
			
## MacOS

Before you start, you need to be aware that is possible to have multiple docker installation (for instance Docker Desktop),
but only an instance of the docker engine must be running at a give time.  
(Colima effectively substitutes the docker egine, running it using a QEMU virtual machine).

### System info
Thi guide has been tested on an Apple MacBooc PRO 16 : 
* M1 Max, 10 CPU Cores, 32 GPU cores
* macOS Ventura 13.2

### Install Colima
* Install Colima : `brew install colima`

### Start Colima
* Start Colima with the desired resources : `colima start --arch x86_64 --memory 4`

### Run x64 container : (in this example a oracle image)
* For this example we will use a simple pre build oralcle image with test password 'MyOracle_2023' :
* Run the container : `docker run --name ora21playground -p 2521:1521 fugeritorg/oracle-21.3.0-xe-playground:2023.0`
* Connect to the container : `docker exec -it ora21playground bash`
* Test oracle connection : `sqlplus sys/MyOracle_2023@//localhost:1521/XEPDB1 AS sysdba`

### To note
* Performance : Even though the x64 images start and run, in those tests they are much slower than in similar native x64 hardware.

### Useful resources
* [Colima repository](https://github.com/abiosoft/colima)
* [Oracle docker images script repository](https://github.com/oracle/docker-images/tree/main/OracleDatabase/SingleInstance)
* [(English) How to setup Docker container Oracle Database 19c for Liferay Development Environment](https://www.dontesta.it/2020/03/15/how-to-setup-docker-container-oracle-database-19c-for-liferay-development-environment/) - Interesting guide about how to setup a custom image based on oracle docker images repository.
* [Running x86_64 Docker Images on Mac M1 Max (Oracle Database 19c)](https://www.dbasolved.com/2022/09/running-x86_64-docker-images-on-mac-m1-max-oracle-database-19c/) - The article where i first read about Colima.
* [Simple playground images based on oracle 21.3.0 express edition](https://hub.docker.com/repository/docker/fugeritorg/oracle-21.3.0-xe-playground/general) - Docker hub repository with playground oracle images (to use only for demo or development).
