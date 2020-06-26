resource "null_resource" "jenkins" {
    depends_on = ["aws_instance.jenkins_project"]
    triggers = {
        always_run = "${timestamp()}"
  }
    provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = "${aws_instance.jenkins_project.public_ip}"
    }
    
    inline = [
      "sudo yum install java${var.java_version} -y",
      "curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo",
      "sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key",
      "sudo yum install ${var.jenkins_version} -y",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins",
      "echo -e $(tput setaf 1 )'Jenkins initialAdminPassword: '$(tput sgr0) $(tput setaf 2)`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`$(tput sgr0)",  
    ] 
  } 
}