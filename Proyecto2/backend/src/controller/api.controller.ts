import * as health from "./health/ping";
import * as parser from "./parser/Parser";
export default {
    ...health,
    ...parser
}