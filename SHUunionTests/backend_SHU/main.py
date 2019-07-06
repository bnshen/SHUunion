from flask import Flask,request,jsonify,send_from_directory
import os
app = Flask(__name__)

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == 'POST':
        for i in request.form:
            print(i,request.form.get(i,''))
        #print('username:{},password:{}'.format(username,password))
        return jsonify({'status':"200"})
    return 'success'

@app.route('/gift',methods=['POST','GET'])
def gift():
    if request.method == 'GET':
        return open('gift.json').read()
    if request.method == 'POST':
        for i in request.form:
            print(i,request.form.get(i,''))
        #print('user_id:{},prize_id:{}'.format(user_id,prize_id))
        return jsonify({'status':"200"})
    return 'success'

@app.route('/ticket',methods = ['POST','GET'])
def ticket():
    if request.method == 'POST':
        for i in request.form:
            print(i,request.form.get(i,''))
        #if userid and ticket_id:
        return jsonify({"status":"200"})
    return 'fail'

@app.route('/message',methods = ['POST','GET'])
def message():
    if request.method == 'GET':
        return open('message.json').read()
    if request.method == 'POST':
        for i in request.form:
            print(i,request.form.get(i,''))
        return jsonify({"status":"200"}) 


@app.route('/rank',methods = ['POST','GET'])
def rank():
    if request.method == 'POST':
        for i in request.form:
            print(i,request.form.get(i,''))
        return jsonify({"status":"200"}) 
    if request.method == 'GET':
        return open('rank.json').read()

@app.route('/news',methods = ['POST','GET'])
def news():
    if request.method == 'POST':
        for i in request.form:
            print(i,request.form.get(i,''))
        return jsonify({"status":"200"}) 
    if request.method == 'GET':
        return open('news.json').read()

@app.route('/favicon.ico')
def favicon():
    # 后端返回文件给前端（浏览器），send_static_file是Flask框架自带的函数
    return app.send_static_file('static/favicon.ico')

@app.route('/download/<string:filename>', methods=['GET'])
def download(filename):
    if request.method == "GET":
        if os.path.isfile(os.path.join('img', filename)):
            return send_from_directory('img', filename, as_attachment=True)
        pass




if __name__ == '__main__':
	#app.run('0.0.0.0',port = 8000,ssl_context=('1_lz-legal-aid.cn_bundle.crt','2_lz-legal-aid.cn.key'))
    app.run('0.0.0.0',port = 8000,debug = True)

