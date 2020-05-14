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

	# ユーザーのセッションを永続的にする
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# 記憶トークン cookie に対応するユーザーを返す
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	# 渡されたユーザーがカレントユーザーであれば true を返す
	def current_user?(user)
		user && user == current_user
	end

	# 永続的セッションを破棄する
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# 渡されたユーザーでログアウトする
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# 記憶した URL (もしくはデフォルト値) にリダイレクト
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# アクセスしようとした URL を覚えておく
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end