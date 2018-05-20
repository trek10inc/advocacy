cd ..

zip \
-x .git/\* \
-x .gitignore \
-x .idea/\* \
-x .serverless/\* \
-r \
-X /tmp/master-bundle.zip ./* .[^.]* # package up the application for deployment

aws s3 cp /tmp/master-bundle.zip s3://${YOUR_BUCKET_HERE}

rm /tmp/master-bundle.zip # rm the zip

cd scripts