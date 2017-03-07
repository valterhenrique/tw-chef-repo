default['mvp']['home']='/srv/mvp'
default['mvp']['repository']='https://github.com/ThoughtWorksInc/infra-problem.git'


default['tw-mvp']['static_port']="8001"
default['tw-mvp']['quote_service_port']="8002"
default['tw-mvp']['newsfeed_service_port']="8003"
default['tw-mvp']['static_url']="http://localhost:"+node['tw-mvp']['static_port']
default['tw-mvp']['quote_service_url']="http://localhost:"+node['tw-mvp']['quote_service_port']
default['tw-mvp']['newsfeed_service_url']="http://localhost:"+node['tw-mvp']['newsfeed_service_port']
