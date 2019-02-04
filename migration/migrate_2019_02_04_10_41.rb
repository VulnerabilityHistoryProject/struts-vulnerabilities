require_relative '../scripts/migration'

def migrate_2019_02_04_10_41
	insert_lines_dir("../migration/cves_test","CVE: CVE-\\d{4}-\\d+","../migration/test_input.txt")
end

migrate_2019_02_04_10_41()