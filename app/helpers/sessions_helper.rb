module SessionsHelper

	# 渡されたユーザーでログインする
	def log_in(user)
		session[:user_id] = user.id
	end

	# 現在ログイン中のユーザーを返す (いる場合)
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
			#@current_userがnilの場合のみ、User.find~を実行。2回目以降はDBへ検索を行わず、処理を軽くする。
		end
	end

	# ユーザーがログインしていれば true、その他なら false を返す
	def logged_in?
		!current_user.nil? #current_userがnilでないことを確認
	end

	# 渡されたユーザーでログアウトする
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

end