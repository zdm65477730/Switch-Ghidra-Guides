import re

def get_build_id():
    with open('uncompressed_ssl.nso0', 'rb') as f:
        f.seek(0x40)
        return(f.read(0x14).hex().upper())

with open('uncompressed_ssl.nso0', 'rb') as fi:
    read_data = fi.read()
    result1 = re.search(rb'\x6a\x00\x80\xd2', read_data)
    result23 = re.search(rb'\x94.{4}\x1f\x08\x00\x71\x43\x01\x00\x54', read_data)
    result4 = re.search(rb'\x88\x16\x00\x12', read_data)
    patch1 = '%06X%s%s' % (result1.start(), '0001', '0A')
    patch2 = '%06X%s%s' % (result23.end() - 4, '0002', '1100')
    patch3 = '%06X%s%s' % (result23.end() - 1, '0001', '14')
    patch4 = '%06X%s%s' % (result4.end(), '0004', '08008052')
    text_file = open(get_build_id() + '.ips', 'wb')
    print('ssl build-id: ' + get_build_id())
    print('ssl offsets and patches at: ' + patch1 + patch2 + patch3 + patch4)
    text_file.write(bytes.fromhex(str('5041544348' + patch1 + patch2 + patch3 + patch4 + '454F46')))
    text_file.close()