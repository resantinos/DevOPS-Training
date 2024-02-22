# DevOPS implementation with Docker Kubernetes and Jenkins
*** This is hardcoded for deployment on DigitalOcean ***

This is a DevOPS CI/CD project including Terraform for intrastructure deployment, Helm for deploying monitoring (Prometheus with Grafana), Anisble for configuration of the Jenkins server, Jenkins, Docker, Kubernetes, Apache2.

## Requirements:
- DigitalOcean account (use this link to registser, you will get me some DO credits and help me improve this project: https://m.do.co/c/a29a96bb183b)
- installed Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- SSH key named "key" in DO
- doctl installed and authenticated locally https://docs.digitalocean.com/reference/doctl/how-to/install/
- installed Ansible https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
## Usages

1. Deploy the infrastructure with terraform.
2. Grab the hosts.ini file and enter your hosts for Asnible (make sure to set correct path to your private key and the correct IP adresses for your droplets)
 - wazuh_server (optional)
 - jenkins_server
3. Launch the jenkins.yml playbook, then docker_ansible_kubectl_doctl_helm.yml
   This assumes you have direct SSH access to your servers, which you should after
- You can lanuch it like this: "ansible-playbook -i hosts.ini jenkins.yml"
4. Activate Jenkins (get the admin pass from the output of the playbook)
- MAKE SURE TO SETUP YOUR JENKINS SECRETS LIKE SPECIFIED BELOW
-  docker - ID:docker - Username and Password - (username is your email which you have used to register to DO, password is the DO API token which you need to generate from the GUI)
-  token - ID:token - secret text - the same token as above
-  cluster - ID:cluster- secret text - this is the kubernetes cluster ID which can be found in the DO GUI
-  cert - ID:cert - this is your database certificate
-  db_hostname - ID:db_hostname - this is your database hostname
5. Setup the Jenkins Pipelines
- run Jekins_Pipelines/build_image_and_push_to_registry first
- run deploy_to_kubernetes
- run deploy_to_help_oneshot
6. You should be good to go from this point.

## Remarks
1. Prometheus will be preconfigured to catch the metrics from the apache pod, apache config is set to accept the traffic from 10.255, change this to your actual IP range. There is no need to expose prometheus to the public. You can, of course if you want to configure additional scrapes.
2. There may be some hardcoded stuff which I forgot about, so make sure to review the code you are launching.
3. There are some issues with connecting with the managed database from phpmyadmin as it is showing error about not valid certificates. I will need to figure out how to automatate the process as the certificate is correctly copied over to the image and is present on the container, however in a wrong format. There is a script to at /tmp of the container which has to be ran to reformat it in order to work.

## Contributing

Feel free to copy, clone, do whatever you want with this code.

## License

Free?

## Acknowledgments

- This is by no means a production ready project, please use this with caution.
- There may be some bugs, any hints are welcome for me to improve this.
