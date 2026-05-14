pipeline {
agent {label 'iac'}

// Ensure environment variables are set as secret text type //
environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
}
stages{
  stage('Terraform Init'){
    steps {
	    dir('./demo') {
                       sh '/usr/local/bin/terraform init'
        }
    }
  }
  stage('Terraform Plan'){
    steps {
	    dir('./demo') {
                       sh '/usr/local/bin/terraform plan -out testplan'
                       sh '/usr/local/bin/terraform show -json testplan > testplan.json'
        }
    }
  }
  stage('Checkov Scan'){
    steps {
      catchError(buildResult: 'SUCCESS', message: 'IAC Misconfigurations found', stageResult: 'UNSTABLE')
      {
	      dir('./demo') {
                      // sh '/home/ubuntu/.local/bin/checkov -f testplan.json'
              sh 'sudo /root/.local/share/pipx/venvs/checkov/bin/checkov -f testplan.json'
        }
      }
    }
  }
  stage('Terraform Apply'){
    steps {
	    dir('./demo') {
                       sh '/usr/local/bin/terraform apply -auto-approve'
        }
    }
  }

  stage('Terraform Destroy'){
    steps {
	    dir('./demo') {
                       sh '/usr/local/bin/terraform plan -out destroyplan -destroy'
                       sh '/usr/local/bin/terraform apply destroyplan'
        }
    }
  }
}
}
