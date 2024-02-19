# DevOPS implementation with Docker Kubernetes and Jenkins
*** This is focusing on deployment on DigitalOcean ***

This is a DevOPS CI/CD project including Terraform for intra creation, Helm for deploying monitoring, Anisble for configuration of the Jenkins server, Jenkins, Docker, Kubernetes, Apache2.

## Requirements:
- DigitalOcean account (use this link to registser, you will get me some DO credits and help me improve this project: https://m.do.co/c/a29a96bb183b)
- installed Terraform
- SSH key named "key" in DO

## Usage

1. Deploy the infrastructure with terraform.
2. Grab the hosts.ini file and enter your hosts for Asnible
 - wazuh_server (optional)
 - jenkins_server
3. Launch the jenkins.yml playbook, then docker_ansible_kubectl_doctl_helm.yml
   This assumes you have direct SSH access to your servers, which you should after
4. Activate Jenkins (get the admin pass from the output of the playbook)
  MAKE SURE TO SETUP YOUR JENKINS VARIABLES
-  docker - ID:docker - Username and Password - (username is your email which you have used to register to DO, password is the DO API token which you need to generate from the GUI)
-  token - ID:token - secret text - the same token as above
-  cluster - ID:cluster- secret text - this is the kubernetes cluster ID which can be found in the DO GUI
5. Setup the Jenkins Pipelines
   

## Contributing

Feel free to copy, clone, do whatever you want with this code.

## License

Free?

## Acknowledgments

- This is by no means a production ready project, please use this with caution.
- There may be some bugs, any hints are welcome for me to improve this.
