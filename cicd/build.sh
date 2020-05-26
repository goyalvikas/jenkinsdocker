pipeline {
  agent any
  parameters {
    string(name: 'REPONAME', defaultValue: 'example/nginx', description: 'AWS ECR Repository Name')
    string(name: 'ECR', defaultValue: '237724776192.dkr.ecr.eu-central-1.amazonaws.com/example/nginx', description: 'AWS ECR Registry URI')
    string(name: 'REGION', defaultValue: 'eu-central-1', description: 'AWS Region code')
    string(name: 'CLUSTER', defaultValue: 'ExampleCluster', description: 'AWS ECS Cluster name')
    string(name: 'TASK', defaultValue: 'ExampleTask', description: 'AWS ECS Task name')
  }
  stages {
    stage('BuildStage') {
      steps {
        sh "./cicd/build.sh -b ${env.BUILD_ID} -n ${params.REPONAME} -e ${params.ECR} -r ${params.REGION}"
      }
    }
    stage('DeployStage') {
      steps {
        sh "./cicd/deploy.sh"
      }
    }
    stage('TestStage') {
      steps {
        sh "./cicd/test.sh"
      }
    }
  }
}
{
    "family": "ExampleTask",
    "containerDefinitions": [
        {
            "image": "URI:NUMBER",
            "name": "ExampleContainer",
            "cpu": 0,
            "memory": 128,
            "essential": true,
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 80
                }
            ]
        }
    ]
}
