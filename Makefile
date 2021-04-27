CUR_DIR = $(CURDIR)

run:
	swift run Feather

env:
	echo 'FEATHER_WORK_DIR="$(CUR_DIR)/"' > .env.development
	echo 'FEATHER_HTTPS=false' >> .env.development
	
clean:
	rm -rf ./Resources/ ./Public/

test:
	swift test --enable-test-discovery
