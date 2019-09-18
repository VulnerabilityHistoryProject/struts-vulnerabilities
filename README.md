# struts-vulnerabilities
Curated vulnerability data for vulnerabilityhistory.org

### First time setup:
1. Make sure you have ruby installed
2. Clone repo
3. Navigate to repo root directory
4. Open Command Prompt/Terminal in this folder
5. Type `gem install mechanize`
6. Type `rake pull:cves`

### How to update CVE .yml files:
1. Navigate to repo root directory
2. Open Command Prompt/Terminal in this folder
3. Type `rake pull:cves`

### Clone struts repo:
1. Type `rake pull:repo`

# Populate gitlog.json with any mentioned SHA in CVE yamls

Use the shepherd tools. Here's an example:

```sh
vhp loadcommits mentioned --repo ~/struts/src
```

# Generate "Weeklies" Git Log Reports

TODO Write these up - would prefer this use shepherd tools
