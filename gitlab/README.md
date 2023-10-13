
---

## **GitLab 設定解釋**

### **基本設定**

1. **外部 URL**
   - `external_url "${GITLAB_EXTERNAL_URL}"`
     - 設定 GitLab 的外部 URL，用戶和 GitLab Runner 訪問 GitLab 實例時所使用。

2. **容器註冊表 URL**
   - `registry_external_url "${REGISTRY_EXTERNAL_URL}"`
     - 設定 GitLab 容器註冊表的外部 URL，容器註冊表允許存儲 Docker 容器映像。

3. **容器註冊表設定**
   - `gitlab_rails['registry_enabled'] = true`
     - 啟用 GitLab 容器註冊表功能。
   - `gitlab_rails['registry_host'] = "${REGISTRY_HOST}"`
     - 設定 GitLab 容器註冊表的主機名稱。
   - `gitlab_rails['registry_port'] = ${REGISTRY_PORT}`
     - 設定 GitLab 容器註冊表的端口號。
   - `gitlab_rails['registry_path'] = "/var/opt/gitlab/gitlab-rails/shared/registry"`
     - 設定 GitLab 容器註冊表的存儲路徑。

### **其他功能設定**

4. **Git LFS**
   - `gitlab_rails['lfs_enabled'] = false`
     - 禁用 Git Large File Storage (LFS) 功能，Git LFS 是一個 Git 擴展，允許更好地處理大文件。

5. **GitLab Pages**
   - `gitlab_rails['pages_enabled'] = false`
     - 禁用 GitLab Pages 功能，GitLab Pages 允許建立、託管和部署靜態網頁。

6. **Mattermost**
   - `mattermost_external_url 'http://no.where'`
     - 設定 Mattermost 的外部 URL，Mattermost 是一個開源的即時通訊平台，與 GitLab 緊密集成。
   - `mattermost['enable'] = false`
     - 禁用 Mattermost 功能。

---

## **GitLab Volumes 解釋**

### **配置**

1. **GitLab 主要配置**
   - `./gitlab/config:/etc/gitlab`
     - 存儲 GitLab 的主要配置文件。
     - 容器內路徑 `/etc/gitlab` 包含 GitLab 的 Omnibus 配置，例如 `gitlab.rb`。
     - 宿主機路徑 `./gitlab/config` 用於持久化這些配置。

### **日誌**

2. **GitLab 日誌**
   - `./gitlab/logs:/var/log/gitlab`
     - 存儲 GitLab 的日誌文件。
     - 容器內路徑 `/var/log/gitlab` 包含所有 GitLab 服務的日誌，例如 `gitlab-rails`、`gitlab-shell` 等。
     - 宿主機路徑 `./gitlab/logs` 用於持久化這些日誌。

### **數據**

3. **GitLab 數據存儲**
   - `./gitlab/data:/var/opt/gitlab`
     - GitLab 的主要數據存儲位置，例如存儲庫數據、數據庫數據等。
     - 容器內路徑 `/var/opt/gitlab` 存儲了 GitLab 的大部分持久化數據。
     - 宿主機路徑 `./gitlab/data` 用於持久化這些數據。

### **容器註冊表**

4. **GitLab 容器註冊表**
   - `./gitlab/registry:/var/opt/gitlab/gitlab-rails/shared/registry`
     - 存儲 GitLab 容器註冊表的數據。
     - 容器內路徑 `/var/opt/gitlab/gitlab-rails/shared/registry` 存儲 Docker 容器映像的註冊表數據。
     - 宿主機路徑 `./gitlab/registry` 用於持久化這些數據。

---

