
class EZSubmission {
  constructor(apiUrl) {
    this.apiUrl = apiUrl;
    this.accessToken = null;
  }
  _config() {
    if (this.accessToken) {
      return {
        headers: {
          Authorization: `Bearer ${this.accessToken}`
        }
      };
    } else {
      return {}
    }
  }
  login(username, password) {
    return axios
      .post(`${this.apiUrl}/login`, { username, password })
      .then((response) => {
        this.accessToken = response.data.access_token;
        return response;
      });
  }
  getLatestAnswers(assignmentUrl, username) {
    return axios.post(`${this.apiUrl}/answers/latest`, { assignment_url: assignmentUrl, username }, this._config());
  }
  submit(submissions) {
    return axios.post(`${this.apiUrl}/submissions`, submissions, this._config());
  }
}
