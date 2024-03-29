include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}


# Dependencies
dependency "networking" {
  config_path = "../../common/networking"

  # Mock outputs for plan to work
  mock_outputs = {
    vpc_id             = "sfasdfasdfasdfas"
    public_subnet_ids  = toset(["Asdfasdfasdfasd", "Asdfasdfasdfasdf"])
    private_subnet_ids = toset(["asdfasdfasdfasdfsf", "Asdfasdfasdasdfsad"])
  }
}

dependency "rds" {
  config_path = "../../common/rds"

  # Mock outputs for plan to work
  mock_outputs = {
    secrets_arn  = "sfasdfasdfasdfas"
    db_host = "mock.host"
    db_port = "mock.db_port"
    db_name = "mock.dbname"
    db_username = "mock.username"
  }
}

dependency "iam-roles" {
  config_path = "../../common/iam"

  # Mock outputs for plan to work
  mock_outputs = {
    ecs_task_execution_role_arn = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    ecs_task_execution_role_id  = "12345678"
  }
}
dependency "sg" {
  config_path = "../../common/sg"

  mock_outputs = {
    sg_ecs_id = "3223423423fsadfsdfasd"
    sg_alb_id = "sasdfs232342342"
  }
}

dependency "ecs_cluster" {
  config_path = "../../common/ecs"

  # Mock outputs for plan to work
  mock_outputs = {
    ecs_cluster_id = "fasdfasfasdfasdfasdf"
    ecs_service_discovery_namespace_id = "awawfawf"
  }
}

dependency "ecr_repo" {
  config_path = "../../common/ecr"

  # Mock outputs for plan to work
  mock_outputs = {
    fe_repo_url        = "fasdfasfasdfasdfasdf"
    be_repo_url        = "fasdfasfasdfasdfasdf"
    collector_repo_url = "fasdfasfasdfasdfasdf"
  }
}

dependency "alb" {
  config_path = "../../common/alb"

  # Mock outputs for plan to work
  mock_outputs = {
    alb_id                             = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    sample_nginx_app_target_group_id   = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    jaeger_app_target_group_id         = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    otlp_fe_app_target_group_id        = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    otlp_be_app_target_group_id        = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    otlp_collector_app_target_group_id = "arn:aws:sdfasdf:us-east-1:759812819291:sdfsd/sdfsd/ae3f54373866d182"
    otlp_collector_fqdn                = "otlp-collector-sdfsd.dev.mira-nf.com"
  }
}

dependency "cloudwatch" {
  config_path = "../../common/cloudwatch"

  # Mock outputs for plan to work
  mock_outputs = {
    otlp_log_group_name = "otlp-nginx-app"

  }
}


inputs = {
  vpc_id             = dependency.networking.outputs.vpc_id
  public_subnet_ids  = dependency.networking.outputs.public_subnet_ids
  private_subnet_ids = dependency.networking.outputs.private_subnet_ids
  sg_ecs_id          = dependency.sg.outputs.sg_ecs_id
  sg_alb_id          = dependency.sg.outputs.sg_alb_id
  ecs_cluster_id     = dependency.ecs_cluster.outputs.ecs_cluster_id
  alb_id             = dependency.alb.outputs.alb_id

  sample_nginx_app_target_group_id   = dependency.alb.outputs.sample_nginx_app_target_group_id
  jaeger_app_target_group_id         = dependency.alb.outputs.jaeger_app_target_group_id
  otlp_fe_app_target_group_id        = dependency.alb.outputs.otlp_fe_app_target_group_id
  otlp_be_app_target_group_id        = dependency.alb.outputs.otlp_be_app_target_group_id
  otlp_collector_app_target_group_id = dependency.alb.outputs.otlp_collector_app_target_group_id
  ecs_task_execution_role_arn        = dependency.iam-roles.outputs.ecs_task_execution_role_arn
  ecs_task_execution_role_id         = dependency.iam-roles.outputs.ecs_task_execution_role_id
  ecs_service_discovery_namespace_id = dependency.ecs_cluster.outputs.ecs_service_discovery_namespace_id
  otlp_log_group_name                = dependency.cloudwatch.outputs.otlp_log_group_name
  db_host                            = dependency.rds.outputs.db_host
  db_port                            = dependency.rds.outputs.db_port
  db_name                            = dependency.rds.outputs.db_name
  db_username                        = dependency.rds.outputs.db_username
  secrets_arn                        = dependency.rds.outputs.secrets_arn
  app_image                          = dependency.ecr_repo.outputs.be_repo_url
}

