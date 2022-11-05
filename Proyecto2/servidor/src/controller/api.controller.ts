import * as healt from "./health/ping";
import * as parser from "./parser/Parser";
export default {
    ...healt,
    ...parser
}