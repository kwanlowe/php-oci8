# php-oci8

## Introduction
CentOS PHP/OCI8 Docker container

First pass at building a CentOS based PHP/OCI8 environment.

## Usage

Open the Oracle web page in your browser:

        http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

Download the current versions and copy to the depot/ directory. For licensing
reasons the RPMs cannot be provided elsewhere. Once downloaded, copy them to
the depot directory:
 
        cp oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm depot/
        cp oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm depot/

Edit the Dockerfile with the names of the RPMs.

Build the container:

        docker build -t centos-php-oci .

Copy your PHP files to the html directory:

        mkdir html
        cp index.php html/

Run the container

        docker run -d -P -p 8080:80 --name php-oci8 -v html:/var/www/html -i centos-php-oci

## TODO

* Deal with logs
* Proper oci_connect example. This is pending me setting up an Oracle server :>.


## Notes

* Instead of copying the RPMs to the image and installing, you can also make them available
over the web and install via:  

 	yum -y install http://path/to/xxx.rpm

* You may also opt to use a tnsnames.ora file. To do so, copy the tnsnames.ora to the 
appropriate path.

