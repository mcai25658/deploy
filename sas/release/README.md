#同步
rsync -avz release/ dls@192.168.23.123:/home/dls/deploy/release
rsync -avz --delete release/ dls@192.168.23.123:/home/dls/deploy/release
