import { coreHttpClient } from "@/api/clients"

class VideosController {
  static API_ENDPOINT = "search";

  static async getList(str) {
    const resp = await coreHttpClient().post(this.API_ENDPOINT, {
      q: str,
      search_params: {
        "misspellings": { "below": 5, "edit_distance": 0 }
      }

    })

    return resp.data
  }
  static async getSearchHelpers(str) {
    const resp = await coreHttpClient().post(this.API_ENDPOINT, {
      q: str,
      search_params: {
        "misspellings": { "below": 5, "edit_distance": 0 }
      },
      "autocomplete": true
    })

    return resp.data
  }
  // static async logIn(login, pass) {
  //   const postData = new URLSearchParams({
  //     username: login,
  //     password: pass,
  //   });
  //   const response = await authHttpClient()
  //     .post(this.API_ENDPOINT, postData)
  //     .catch((err) => {
  //       return err;
  //     });
  //   return response;
  // }
}

export { VideosController };
