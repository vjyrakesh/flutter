import sqlite3
import sys


class DBConnection(object):
    """
    Context manager for database connection.
    Database is assumed to be named as 'ss4db.db' for now with no authorization.
    """

    def __init__(self, db_name='ss4db.db', username='', password=''):
        self.db_name = db_name
        self.db_username = username
        self.db_password = password

    def __enter__(self):
        self.conn = sqlite3.connect('shopping.db')
        return self.conn.cursor()

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.conn.commit()
        self.conn.close()
        return False


def add_items(items_list):
    print(items_list)
    with DBConnection() as cur:
        # Insert the record into database
        for one_item in items_list:
            if '\n' in one_item:
                one_item = one_item.replace('\n', '')
            print(one_item)
            cur.execute("insert into items(item_name) values(\'{0}\')".format(one_item))
            print(one_item + ' added to database')


def add_items_from_file(file_name):
    with open(file_name, 'r') as file_obj:
        add_items(file_obj.readlines())


if __name__ == "__main__":
    add_items_from_file(sys.argv[1])
