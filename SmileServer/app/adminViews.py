from app import app, db
import flask
from flask import request
from flask.ext.admin import Admin, BaseView, expose
from flask.ext.admin.contrib.sqlamodel import ModelView
from flask.ext.admin.contrib.fileadmin import FileAdmin
import os.path as op
from models import User, Data, City, Cell, ROLE_SUPERADMIN, ROLE_NORMAL, ROLE_FOLLOWED, ROLE_ADMIN
from flask.ext import login


class MyView(BaseView):
    @expose('/')
    def index(self):
        return self.render('indexAdmin.html')



#pragmamark Flask-Admin
class MyUserView(ModelView):

    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(MyUserView, self).__init__(User, session, **kwargs)

    # def is_accessible(self):
    #     username = request.authorization.username
    #     user = User.query.filter_by(email=username).first()
    #     return user.role == ROLE_SUPERADMIN

     #   return login.current_user.is_authenticated() and login.current_user.is_admin()



class MyCityView(ModelView):

    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(MyCityView, self).__init__(City, session, **kwargs)

    #def is_accessible(self):
    #    return login.current_user.is_authenticated() and login.current_user.is_admin()



class MyCellView(ModelView):

    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(MyCellView, self).__init__(Cell, session, **kwargs)

    #def is_accessible(self):
    #    return login.current_user.is_authenticated() and login.current_user.is_admin()


class MyDataView(ModelView):

    def __init__(self, session, **kwargs):
        # You can pass name and other parameters if you want to
        super(MyDataView, self).__init__(Data, session, **kwargs)

    #def is_accessible(self):
    #    return login.current_user.is_authenticated() and login.current_user.is_admin()



class MyFileAdmin(FileAdmin):

    def __init__(self, path, dir, **kwargs):
        # You can pass name and other parameters if you want to
        super(MyFileAdmin, self).__init__(path, dir, **kwargs)

   # def is_accessible(self):
    #    return login.current_user.is_authenticated() and login.current_user.is_admin()


admin = Admin(app, name='SmileSpaces')
admin.add_view(MyUserView(db.session))
admin.add_view(MyCityView(db.session))
admin.add_view(MyCellView(db.session))
admin.add_view(MyDataView(db.session))

path = op.join(op.dirname(__file__), 'static')
admin.add_view(MyFileAdmin(path, '/static/', name='Static Files'))
