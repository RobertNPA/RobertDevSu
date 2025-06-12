import sequelize from './shared/database/database.js'
import { usersRouter } from "./users/router.js"
import express from 'express'

const app = express()
const PORT = 8000

sequelize.sync({ force: true }).then(() => {
    process.stdout.write('Database is ready\n')
})

app.use(express.json())
app.use('/api/users', usersRouter)

const server = app.listen(PORT, () => {
    process.stdout.write(`Server running on port ${PORT}\n`)
})

export { app, server }