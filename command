#作業ブランチ変更方法
git co -b (作業ブランチ名)
git add -A
git commit -m ''
git co master
git merge (作業ブランチ名)
git push

#dockerのエイリアス
alias d='docker'
alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcps='docker-compose ps'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcex='docker-compose exec'
alias dcd='docker-compose down'
alias dcl='docker-compose logs'

ssh -i ~/.ssh/aws-keypair-syuwakai.pem ec2-user@35.74.194.26

ps aux | grep unicorn && sudo service nginx restart && sudo service mysqld restart

bundle exec rails db:migrate:reset RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
rails db:seed RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1

